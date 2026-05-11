import 'package:core/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:theme_module/theme_module.dart';

class ProductSettingsTile extends StatelessWidget {
  const ProductSettingsTile._({required this.label, this.trailing, this.onTap, super.key});

  factory ProductSettingsTile.toggle({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
    Key? key,
  }) {
    return ProductSettingsTile._(
      key: key,
      label: label,
      trailing: _ToggleTrailing(value: value, onChanged: onChanged),
      onTap: () => onChanged(!value),
    );
  }

  factory ProductSettingsTile.navigation({
    required String label,
    required String value,
    required VoidCallback onTap,
    Key? key,
  }) {
    return ProductSettingsTile._(
      key: key,
      label: label,
      trailing: _NavigationTrailing(value: value),
      onTap: onTap,
    );
  }

  factory ProductSettingsTile.value({required String label, required String value, Key? key}) {
    return ProductSettingsTile._(
      key: key,
      label: label,
      trailing: _ValueTrailing(value: value),
    );
  }

  factory ProductSettingsTile.action({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    Key? key,
    Widget? trailing,
  }) {
    return ProductSettingsTile._(
      key: key,
      label: label,
      trailing: trailing ?? _ActionTrailing(icon: icon),
      onTap: onTap,
    );
  }

  final String label;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Dimensions.borderRadius),
      child: SizedBox(
        height: CustomWidgetDimensions.settingsTileHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.k16),
          child: Row(
            children: [
              Expanded(child: Text(label, style: context.textTheme.bodyLarge)),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}

class _ToggleTrailing extends StatelessWidget {
  const _ToggleTrailing({required this.value, required this.onChanged});
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(value: value, onChanged: onChanged);
  }
}

class _NavigationTrailing extends StatelessWidget {
  const _NavigationTrailing({required this.value});
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.outline)),
        const SizedBox(width: Dimensions.k4),
        Icon(Icons.chevron_right, color: context.colorScheme.outline, size: Dimensions.k20),
      ],
    );
  }
}

class _ValueTrailing extends StatelessWidget {
  const _ValueTrailing({required this.value});
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(value, style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.outline));
  }
}

class _ActionTrailing extends StatelessWidget {
  const _ActionTrailing({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(icon, color: context.colorScheme.outline, size: Dimensions.k20);
  }
}
