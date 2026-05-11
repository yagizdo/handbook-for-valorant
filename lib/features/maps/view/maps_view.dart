import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:core/constants/dimensions.dart';
import 'package:core/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:handbook_for_valorant/features/maps/cubit/map_cubit.dart';
import 'package:handbook_for_valorant/features/maps/cubit/map_state.dart';
import 'package:handbook_for_valorant/features/maps/model/map_model.dart';
import 'package:handbook_for_valorant/features/maps/widget/map_card.dart';
import 'package:handbook_for_valorant/product/widgets/product_error.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:theme_module/theme_module.dart';

@RoutePage()
class MapsView extends StatefulWidget {
  const MapsView({super.key});

  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  @override
  void initState() {
    super.initState();
    unawaited(context.read<MapCubit>().loadMaps());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(Dimensions.k16, Dimensions.k16, Dimensions.k16, Dimensions.k8),
            child: Text(LocaleKeys.maps_title.tr().toUpperCase(), style: context.textTheme.headlineSmall),
          ),
          Gaps.g12,
          const Expanded(child: _MapsContent()),
        ],
      ),
    );
  }
}

class _MapsContent extends StatelessWidget {
  const _MapsContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        return switch (state) {
          MapStateInitial() => const SizedBox.shrink(),
          MapStateLoading() => const _SkeletonMapsList(),
          MapStateEmpty() => const _EmptyMapsList(),
          MapStateSuccess(:final data) => _MapsList(maps: data.maps),
          MapStateError(:final errorMessage) => ProductError(
            message: errorMessage,
            onRetry: () => context.read<MapCubit>().loadMaps(),
          ),
        };
      },
    );
  }
}

class _EmptyMapsList extends StatelessWidget {
  const _EmptyMapsList();

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(LocaleKeys.maps_empty.tr(), style: context.textTheme.titleMedium));
  }
}

class _SkeletonMapsList extends StatelessWidget {
  const _SkeletonMapsList();

  static final List<MapModel> _fakePlaceholderMaps = List.generate(
    6,
    (index) =>
        MapModel(uuid: 'placeholder-$index', displayName: 'Map Name', coordinates: '00\u00b000\'00"N 00\u00b000\'00"W'),
  );

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Skeletonizer(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.k12),
          itemCount: _fakePlaceholderMaps.length,
          separatorBuilder: (_, _) => Gaps.g12,
          itemBuilder: (context, index) {
            return MapCard(map: _fakePlaceholderMaps[index]);
          },
        ),
      ),
    );
  }
}

class _MapsList extends StatelessWidget {
  const _MapsList({required this.maps});
  final List<MapModel> maps;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<MapCubit>().loadMaps(),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.k12),
        itemCount: maps.length,
        separatorBuilder: (_, _) => Gaps.g12,
        itemBuilder: (context, index) {
          return MapCard(map: maps[index]);
        },
      ),
    );
  }
}
