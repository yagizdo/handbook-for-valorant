import 'package:core/logger/product_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:handbook_for_valorant/features/ranks/cubit/ranks_state.dart';
import 'package:handbook_for_valorant/features/ranks/model/ranks_success_model.dart';
import 'package:handbook_for_valorant/features/ranks/service/rank_service.dart';
import 'package:handbook_for_valorant/product/constants/app_constants.dart';
import 'package:handbook_for_valorant/product/locator/base_cubit.dart';

class RanksCubit extends Cubit<RanksState> with BaseCubit<RanksState> {
  RanksCubit({required RankService rankService}) : _rankService = rankService, super(const RanksState.initial());
  final RankService _rankService;

  Future<void> loadRanks({bool forceRefresh = false}) async {
    emit(const RanksState.loading());
    try {
      final ranks = await _rankService.getRanks(forceRefresh: forceRefresh);
      if (ranks.isEmpty) {
        safeEmit(const RanksState.empty());
        return;
      }
      safeEmit(RanksState.success(RanksSuccessModel(allRanks: ranks)));
    } on Exception catch (e) {
      ProductLogger.e(e.toString(), tag: AppConstants.ranksCubitLogTag);
      safeEmit(RanksState.error(LocaleKeys.common_error_loadFailed.tr()));
    }
  }
}
