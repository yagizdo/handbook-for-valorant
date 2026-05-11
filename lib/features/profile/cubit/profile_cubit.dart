import 'dart:ui';

import 'package:core/logger/product_logger.dart';
import 'package:core/service/review_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handbook_for_valorant/features/profile/cubit/profile_state.dart';
import 'package:handbook_for_valorant/product/cache/cache_manager.dart';
import 'package:handbook_for_valorant/product/constants/app_constants.dart';
import 'package:handbook_for_valorant/product/locator/base_cubit.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfileCubit extends Cubit<ProfileState> with BaseCubit<ProfileState> {
  ProfileCubit({
    required ReviewService reviewService,
    required CacheManager cacheManager,
    required VoidCallback onDataRefreshRequested,
  }) : _reviewService = reviewService,
       _cacheManager = cacheManager,
       _onDataRefreshRequested = onDataRefreshRequested,
       super(const ProfileState());
  final ReviewService _reviewService;
  final CacheManager _cacheManager;
  final VoidCallback _onDataRefreshRequested;

  Future<void> initialize() async {
    await getAppVersion();
  }

  Future<void> getAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      safeEmit(state.copyWith(appVersion: packageInfo.version));
    } on Exception catch (e) {
      ProductLogger.e(e.toString(), tag: AppConstants.profileCubitLogTag);
    }
  }

  void changeLanguage(String language) {
    networkModel.language = language;
    _onDataRefreshRequested();
  }

  Future<void> requestReview() async {
    await _reviewService.requestReview();
  }

  Future<void> clearCache() async {
    emit(state.copyWith(isClearingCache: true));
    try {
      _cacheManager.clearAll();
      _onDataRefreshRequested();
      safeEmit(state.copyWith(isClearingCache: false));
    } on Exception catch (e) {
      ProductLogger.e(e.toString(), tag: AppConstants.profileCubitLogTag);
      safeEmit(state.copyWith(isClearingCache: false));
    }
  }
}
