import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:lint_rules/src/avoid_bare_emit_after_await.dart';

PluginBase createPlugin() => _LintRules();

class _LintRules extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [const AvoidBareEmitAfterAwait()];
}
