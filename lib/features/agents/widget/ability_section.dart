import 'package:core/constants/dimensions.dart';
import 'package:core/constants/durations.dart';
import 'package:core/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:handbook_for_valorant/features/agents/constants/agent_ability_constants.dart';
import 'package:handbook_for_valorant/features/agents/model/ability_model.dart';
import 'package:handbook_for_valorant/product/widgets/image/product_image.dart';
import 'package:theme_module/theme_module.dart';

class AbilitySection extends StatefulWidget {
  const AbilitySection({required this.abilities, required this.agentColors, super.key});
  final List<AbilityModel> abilities;
  final List<Color> agentColors;

  @override
  State<AbilitySection> createState() => _AbilitySectionState();
}

class _AbilitySectionState extends State<AbilitySection> {
  int _selectedIndex = 0;

  Color get _accentColor => widget.agentColors.isNotEmpty ? widget.agentColors.first : context.colorScheme.error;

  @override
  Widget build(BuildContext context) {
    if (widget.abilities.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        Gaps.g24,
        Text(
          AgentAbilityConstants.sectionTitle,
          style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        Gaps.g16,
        _AbilityIconList(
          selectedIndex: _selectedIndex,
          abilities: widget.abilities,
          accentColor: _accentColor,
          onSelected: (index) => setState(() => _selectedIndex = index),
        ),
        Gaps.g24,
        _AbilityDetailCard(
          selectedIndex: _selectedIndex,
          abilities: widget.abilities,
          accentColor: _accentColor,
          onSelected: (index) => setState(() => _selectedIndex = index),
        ),
      ],
    );
  }
}

class _AbilityIconList extends StatelessWidget {
  const _AbilityIconList({
    required this.selectedIndex,
    required this.abilities,
    required this.accentColor,
    required this.onSelected,
  });
  final int selectedIndex;
  final List<AbilityModel> abilities;
  final Color accentColor;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CustomWidgetDimensions.abilityIconListHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: abilities.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          final ability = abilities[index];

          return GestureDetector(
            onTap: () => onSelected(index),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.k6),
              child: AnimatedContainer(
                duration: AppDurations.ms200,
                curve: Curves.easeInOut,
                width: CustomWidgetDimensions.abilityIconContainerSize,
                height: CustomWidgetDimensions.abilityIconContainerSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? accentColor : null,
                  border: Border.all(
                    color: isSelected ? accentColor : context.colorScheme.onSurface.withValues(alpha: 0.3),
                    width: CustomWidgetDimensions.abilityIconBorderWidth,
                  ),
                ),
                child: AnimatedScale(
                  scale: isSelected ? 1.1 : 1.0,
                  duration: AppDurations.ms200,
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.k10),
                    child: ability.displayIcon != null
                        ? ProductImage.network(
                            path: ability.displayIcon!,
                            errorWidget: Icon(
                              Icons.error,
                              color: context.colorScheme.onSurface.withValues(alpha: 0.24),
                              size: CustomWidgetDimensions.abilityIconSize,
                            ),
                          )
                        : Icon(
                            Icons.help_outline,
                            color: context.colorScheme.onSurface.withValues(alpha: 0.54),
                            size: CustomWidgetDimensions.abilityIconSize,
                          ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AbilityDetailCard extends StatelessWidget {
  const _AbilityDetailCard({
    required this.selectedIndex,
    required this.abilities,
    required this.accentColor,
    required this.onSelected,
  });
  final int selectedIndex;
  final List<AbilityModel> abilities;
  final Color accentColor;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final ability = abilities[selectedIndex];
    final slotKey = AgentAbilityConstants.abilitySlotKeys[ability.slot] ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.k12),
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity == null) return;
          if (details.primaryVelocity! < 0 && selectedIndex < abilities.length - 1) {
            onSelected(selectedIndex + 1);
          } else if (details.primaryVelocity! > 0 && selectedIndex > 0) {
            onSelected(selectedIndex - 1);
          }
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(Dimensions.k16),
          decoration: BoxDecoration(
            color: context.colorScheme.onSurface.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(Dimensions.cardBorderRadius),
            border: Border.all(color: context.colorScheme.onSurface.withValues(alpha: 0.1)),
          ),
          child: AnimatedSwitcher(
            duration: AppDurations.ms200,
            child: Column(
              key: ValueKey(selectedIndex),
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Ability header: key badge + icon + name
                Row(
                  children: [
                    if (slotKey.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.k8, vertical: Dimensions.k4),
                        decoration: BoxDecoration(
                          color: accentColor,
                          borderRadius: BorderRadius.circular(Dimensions.k6),
                        ),
                        child: Text(
                          slotKey,
                          style: context.textTheme.labelMedium?.copyWith(
                            color: context.colorScheme.onPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    Gaps.g10,
                    if (ability.displayIcon != null)
                      SizedBox(
                        width: CustomWidgetDimensions.abilityDetailIconSize,
                        height: CustomWidgetDimensions.abilityDetailIconSize,
                        child: ProductImage.network(path: ability.displayIcon!),
                      ),
                    Gaps.g8,
                    Expanded(
                      child: Text(
                        ability.displayName ?? '',
                        style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                Gaps.g12,
                Text(
                  ability.description ?? '',
                  maxLines: CustomWidgetDimensions.abilityDescriptionMaxLines,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodySmall?.copyWith(
                    letterSpacing: 0.3,
                    height: 1.4,
                    color: context.colorScheme.onSurface.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
