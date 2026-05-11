import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Warns when `emit()` is called after an `await` in a class that uses
/// `BaseCubit`. Use `safeEmit()` instead to guard against emitting on a
/// closed cubit.
class AvoidBareEmitAfterAwait extends DartLintRule {
  const AvoidBareEmitAfterAwait() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_bare_emit_after_await',
    problemMessage:
        'Use safeEmit() instead of emit() after an await. '
        'The cubit may have been closed during the async gap.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    // TODO: Replace with DiagnosticReporter when custom_lint_builder updates
    // its API to use the non-deprecated type.
    // ignore: deprecated_member_use
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((node) {
      if (!_usesBaseCubit(node)) return;

      for (final member in node.members) {
        if (member is MethodDeclaration && member.body is BlockFunctionBody) {
          final body = member.body as BlockFunctionBody;
          final visitor = _EmitAfterAwaitVisitor();
          body.block.accept(visitor);

          for (final emitNode in visitor.violations) {
            reporter.atNode(emitNode, code);
          }
        }
      }
    });
  }

  /// Checks whether [node] uses the `BaseCubit` mixin.
  bool _usesBaseCubit(ClassDeclaration node) {
    final element = node.declaredFragment?.element;
    if (element == null) return false;

    for (final mixin in element.mixins) {
      if (mixin.element.name == 'BaseCubit') {
        return true;
      }
    }
    return false;
  }
}

/// Branch-aware visitor that tracks whether an `await` has been seen
/// and flags bare `emit()` / `this.emit()` / `super.emit()` calls.
///
/// Handles branching (if/else, switch), exception handling (try/catch/finally),
/// loops, and skips closures / nested function expressions.
class _EmitAfterAwaitVisitor extends RecursiveAstVisitor<void> {
  final List<MethodInvocation> violations = [];
  bool _hasSeenAwait = false;

  @override
  void visitAwaitExpression(AwaitExpression node) {
    _hasSeenAwait = true;
    super.visitAwaitExpression(node);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (_hasSeenAwait && _isUnsafeEmit(node)) {
      violations.add(node);
    }
    super.visitMethodInvocation(node);
  }

  /// Returns `true` for `emit(...)`, `this.emit(...)`, `super.emit(...)`.
  /// Returns `false` for `safeEmit(...)` or `someVar.emit(...)`.
  bool _isUnsafeEmit(MethodInvocation node) {
    final name = node.methodName.name;
    if (name != 'emit') return false;

    final target = node.target;
    // Bare call: emit(state)
    if (target == null) return true;
    // this.emit(state)
    if (target is ThisExpression) return true;
    // super.emit(state)
    if (target is SuperExpression) return true;

    return false;
  }

  // ── Branching: if / else ──────────────────────────────────────────────

  @override
  void visitIfStatement(IfStatement node) {
    // Visit condition — may contain await.
    node.expression.accept(this);

    final savedAwait = _hasSeenAwait;

    // Visit then-branch starting from saved state.
    _hasSeenAwait = savedAwait;
    node.thenStatement.accept(this);
    final awaitAfterThen = _hasSeenAwait;

    // Visit else-branch starting from saved state.
    _hasSeenAwait = savedAwait;
    node.elseStatement?.accept(this);
    final awaitAfterElse = _hasSeenAwait;

    // After if/else: await seen if it was seen before OR in any branch.
    _hasSeenAwait = savedAwait || awaitAfterThen || awaitAfterElse;
  }

  // ── Exception handling: try / catch / finally ─────────────────────────

  @override
  void visitTryStatement(TryStatement node) {
    // Visit try body.
    node.body.accept(this);
    final awaitAfterTry = _hasSeenAwait;

    // Visit each catch clause — await in try should flag emit in catch.
    for (final catchClause in node.catchClauses) {
      _hasSeenAwait = awaitAfterTry;
      catchClause.accept(this);
    }

    // Visit finally — await in try should flag emit in finally.
    if (node.finallyBlock != null) {
      _hasSeenAwait = awaitAfterTry;
      node.finallyBlock!.accept(this);
    }
  }

  // ── Switch ────────────────────────────────────────────────────────────

  @override
  void visitSwitchStatement(SwitchStatement node) {
    // Visit the switch expression.
    node.expression.accept(this);
    final savedAwait = _hasSeenAwait;

    var anyBranchHadAwait = false;

    for (final member in node.members) {
      // Each case starts from the state before the switch.
      _hasSeenAwait = savedAwait;
      member.accept(this);
      anyBranchHadAwait = anyBranchHadAwait || _hasSeenAwait;
    }

    _hasSeenAwait = savedAwait || anyBranchHadAwait;
  }

  // ── Closures / nested functions: do NOT propagate await ────────────────

  @override
  void visitFunctionExpression(FunctionExpression node) {
    // Skip — await in outer scope should not affect emit inside a closure,
    // and await inside a closure should not affect emit outside.
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    // Skip nested function declarations.
  }
}
