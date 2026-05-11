import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:core/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:handbook_for_valorant/features/ranks/cubit/ranks_cubit.dart';
import 'package:handbook_for_valorant/features/ranks/cubit/ranks_state.dart';
import 'package:handbook_for_valorant/features/ranks/model/rank_model.dart';
import 'package:handbook_for_valorant/features/ranks/widget/rank_card.dart';
import 'package:handbook_for_valorant/product/widgets/product_error.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:theme_module/theme_module.dart';

@RoutePage()
class RanksView extends StatefulWidget {
  const RanksView({super.key});

  @override
  State<RanksView> createState() => _RanksViewState();
}

class _RanksViewState extends State<RanksView> {
  @override
  void initState() {
    super.initState();
    unawaited(context.read<RanksCubit>().loadRanks());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(Dimensions.k16, Dimensions.k20, Dimensions.k16, Dimensions.k4),
            child: Text(LocaleKeys.ranks_title.tr(), style: context.textTheme.headlineLarge),
          ),
          const Expanded(child: _RanksContent()),
        ],
      ),
    );
  }
}

class _RanksContent extends StatelessWidget {
  const _RanksContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RanksCubit, RanksState>(
      builder: (context, state) {
        return switch (state) {
          RanksStateInitial() => const SizedBox.shrink(),
          RanksStateLoading() => const _SkeletonRanksList(),
          RanksStateEmpty() => Center(child: Text(LocaleKeys.ranks_empty.tr())),
          RanksStateSuccess(:final data) => _RanksList(ranks: data.allRanks),
          RanksStateError(:final errorMessage) => ProductError(
            message: errorMessage,
            onRetry: () => context.read<RanksCubit>().loadRanks(),
          ),
        };
      },
    );
  }
}

class _SkeletonRanksList extends StatelessWidget {
  const _SkeletonRanksList();

  List<RankModel> get _fakePlaceholderRanks =>
      List.generate(9, (index) => RankModel(tier: index + 1, tierName: 'Rank Name', divisionName: 'iron'));

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: GridView.builder(
        padding: const EdgeInsets.all(Dimensions.k12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: CustomWidgetDimensions.rankCardAspectRatio,
          crossAxisSpacing: Dimensions.k8,
          mainAxisSpacing: Dimensions.k8,
        ),
        itemCount: _fakePlaceholderRanks.length,
        itemBuilder: (context, index) => RankCard(rank: _fakePlaceholderRanks[index]),
      ),
    );
  }
}

class _RanksList extends StatelessWidget {
  const _RanksList({required this.ranks});
  final List<RankModel> ranks;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<RanksCubit>().loadRanks(forceRefresh: true),
      child: GridView.builder(
        padding: const EdgeInsets.all(Dimensions.k12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: CustomWidgetDimensions.rankCardAspectRatio,
          crossAxisSpacing: Dimensions.k8,
          mainAxisSpacing: Dimensions.k8,
        ),
        itemCount: ranks.length,
        itemBuilder: (context, index) => RankCard(rank: ranks[index]),
      ),
    );
  }
}
