import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:core/constants/dimensions.dart';
import 'package:core/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:handbook_for_valorant/features/weapons/cubit/weapon_cubit.dart';
import 'package:handbook_for_valorant/features/weapons/cubit/weapon_state.dart';
import 'package:handbook_for_valorant/features/weapons/model/weapon_model.dart';
import 'package:handbook_for_valorant/features/weapons/widget/weapon_card.dart';
import 'package:handbook_for_valorant/product/widgets/product_error.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:theme_module/theme_module.dart';

@RoutePage()
class WeaponsView extends StatefulWidget {
  const WeaponsView({super.key});

  @override
  State<WeaponsView> createState() => _WeaponsViewState();
}

class _WeaponsViewState extends State<WeaponsView> {
  @override
  void initState() {
    super.initState();
    unawaited(context.read<WeaponCubit>().loadWeapons());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(Dimensions.k16, Dimensions.k16, Dimensions.k16, Dimensions.k8),
            child: Text(LocaleKeys.weapons_title.tr().toUpperCase(), style: context.textTheme.headlineSmall),
          ),
          Gaps.g12,
          const Expanded(child: _WeaponsContent()),
        ],
      ),
    );
  }
}

class _WeaponsContent extends StatelessWidget {
  const _WeaponsContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeaponCubit, WeaponState>(
      builder: (context, state) {
        return switch (state) {
          WeaponStateInitial() => const SizedBox.shrink(),
          WeaponStateLoading() => const _SkeletonWeaponsList(),
          WeaponStateEmpty() => const _EmptyWeaponsList(),
          WeaponStateSuccess(:final data) => _WeaponsList(weapons: data.weapons),
          WeaponStateError(:final errorMessage) => ProductError(
            message: errorMessage,
            onRetry: () => context.read<WeaponCubit>().loadWeapons(forceRefresh: true),
          ),
        };
      },
    );
  }
}

class _EmptyWeaponsList extends StatelessWidget {
  const _EmptyWeaponsList();

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(LocaleKeys.weapons_empty.tr(), style: context.textTheme.titleMedium));
  }
}

class _SkeletonWeaponsList extends StatelessWidget {
  const _SkeletonWeaponsList();

  static final List<WeaponModel> _fakePlaceholderWeapons = List.generate(
    6,
    (index) => WeaponModel(uuid: 'placeholder-$index', displayName: 'Weapon Name'),
  );

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Skeletonizer(
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.k12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: Dimensions.k12,
            mainAxisSpacing: Dimensions.k12,
            childAspectRatio: CustomWidgetDimensions.weaponCardAspectRatio,
          ),
          itemCount: _fakePlaceholderWeapons.length,
          itemBuilder: (context, index) {
            return WeaponCard(weapon: _fakePlaceholderWeapons[index]);
          },
        ),
      ),
    );
  }
}

class _WeaponsList extends StatelessWidget {
  const _WeaponsList({required this.weapons});
  final List<WeaponModel> weapons;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<WeaponCubit>().loadWeapons(forceRefresh: true),
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.k12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: Dimensions.k12,
          mainAxisSpacing: Dimensions.k12,
          childAspectRatio: CustomWidgetDimensions.weaponCardAspectRatio,
        ),
        itemCount: weapons.length,
        itemBuilder: (context, index) {
          return WeaponCard(weapon: weapons[index]);
        },
      ),
    );
  }
}
