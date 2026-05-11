import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:core/constants/dimensions.dart';
import 'package:core/constants/durations.dart';
import 'package:core/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:handbook_for_valorant/features/weapons/model/skin_model.dart';
import 'package:handbook_for_valorant/features/weapons/model/weapon_model.dart';
import 'package:handbook_for_valorant/features/weapons/widget/skin_card.dart';
import 'package:handbook_for_valorant/product/router/app_router.gr.dart';
import 'package:handbook_for_valorant/product/widgets/buttons/product_back_button_overlay.dart';
import 'package:handbook_for_valorant/product/widgets/product_error.dart';
import 'package:handbook_for_valorant/product/widgets/product_scaffold.dart';
import 'package:theme_module/theme_module.dart';

@RoutePage()
class WeaponSkinsView extends StatefulWidget {
  const WeaponSkinsView({required this.weapon, super.key});

  final WeaponModel weapon;

  @override
  State<WeaponSkinsView> createState() => _WeaponSkinsViewState();
}

class _WeaponSkinsViewState extends State<WeaponSkinsView> {
  final _searchController = TextEditingController();
  Timer? _debounceTimer;
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  List<SkinModel> get _filteredSkins {
    return widget.weapon.skins.where((s) => s.displayIcon != null).where((s) {
      if (_searchQuery.isEmpty) return true;
      return s.displayName.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void _onSearchChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(AppDurations.ms300, () {
      setState(() => _searchQuery = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredSkins = _filteredSkins;

    return ProductScaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SkinsHeader(weaponName: widget.weapon.displayName, skinCount: filteredSkins.length),
              _SearchField(controller: _searchController, onChanged: _onSearchChanged),
              Expanded(
                child: filteredSkins.isEmpty
                    ? ProductError(message: LocaleKeys.weapons_empty.tr())
                    : GridView.builder(
                        padding: const EdgeInsets.all(Dimensions.k16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: Dimensions.k12,
                          mainAxisSpacing: Dimensions.k12,
                          childAspectRatio: CustomWidgetDimensions.weaponSkinGridAspectRatio,
                        ),
                        itemCount: filteredSkins.length,
                        itemBuilder: (context, index) => SkinCard(
                          skin: filteredSkins[index],
                          onTap: () => context.router.push(SkinDetailRoute(skin: filteredSkins[index])),
                        ),
                      ),
              ),
            ],
          ),
          const ProductBackButtonOverlay(),
        ],
      ),
    );
  }
}

class _SkinsHeader extends StatelessWidget {
  const _SkinsHeader({required this.weaponName, required this.skinCount});
  final String weaponName;
  final int skinCount;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Dimensions.k60, Dimensions.k16, Dimensions.k16, 0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                weaponName,
                style: context.textTheme.headlineMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Gaps.g8,
            Text(
              '$skinCount',
              style: context.textTheme.labelMedium?.copyWith(
                color: context.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller, required this.onChanged});
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.k16, Dimensions.k12, Dimensions.k16, 0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: LocaleKeys.weapons_skins_search.tr(),
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: context.colorScheme.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.borderRadius),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
