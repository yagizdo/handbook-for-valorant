import 'dart:async';

import 'package:core/index.dart';
import 'package:get_it/get_it.dart';
import 'package:handbook_for_valorant/features/agents/cubit/agent_cubit.dart';
import 'package:handbook_for_valorant/features/agents/service/agent_service.dart';
import 'package:handbook_for_valorant/features/maps/cubit/map_cubit.dart';
import 'package:handbook_for_valorant/features/maps/service/map_service.dart';
import 'package:handbook_for_valorant/features/profile/cubit/profile_cubit.dart';
import 'package:handbook_for_valorant/features/ranks/cubit/ranks_cubit.dart';
import 'package:handbook_for_valorant/features/ranks/model/rank_entity.dart';
import 'package:handbook_for_valorant/features/ranks/service/rank_service.dart';
import 'package:handbook_for_valorant/features/weapons/cubit/weapon_cubit.dart';
import 'package:handbook_for_valorant/features/weapons/service/weapon_service.dart';
import 'package:handbook_for_valorant/product/cache/cache_manager.dart';
import 'package:handbook_for_valorant/product/cubit/connectivity_cubit.dart';
import 'package:handbook_for_valorant/product/model/theme_entity.dart';
import 'package:handbook_for_valorant/product/model/theme_repository_adapter.dart';
import 'package:handbook_for_valorant/product/network/product_network_model.dart';
import 'package:theme_module/theme_module.dart';

final class BaseContainer {
  BaseContainer._();
  static final BaseContainer _instance = BaseContainer._();

  static BaseContainer get instance => _instance;

  final _getIt = GetIt.instance;

  void setup() {
    final store = ObjectBoxStore.instance;

    // Repositories
    _getIt.registerSingleton<BaseRepository<ThemeModel>>(
      ThemeRepositoryAdapter(ObjectBoxRepository<ThemeEntity>(store)),
    );

    // Network
    _getIt.registerSingleton<ProductNetworkModel>(ProductNetworkModel());

    // Services
    _getIt.registerSingleton<AgentService>(AgentService(networkModel: _getIt<ProductNetworkModel>()));
    _getIt.registerSingleton<MapService>(MapService(networkModel: _getIt<ProductNetworkModel>()));
    _getIt.registerSingleton<WeaponService>(WeaponService(networkModel: _getIt<ProductNetworkModel>()));
    _getIt.registerSingleton<ReviewService>(ReviewService());
    _getIt.registerSingleton<BaseRepository<RankEntity>>(ObjectBoxRepository<RankEntity>(store));
    _getIt.registerSingleton<RankService>(
      RankService(networkModel: _getIt<ProductNetworkModel>(), repository: _getIt<BaseRepository<RankEntity>>()),
    );
    _getIt.registerSingleton<CacheManager>(CacheManager([_getIt<BaseRepository<RankEntity>>()]));

    // Cubits
    _getIt.registerSingleton<ThemeCubit>(
      ThemeCubit(themeRepository: _getIt<BaseRepository<ThemeModel>>())..init(),
      dispose: (cubit) => cubit.close(),
    );
    _getIt.registerSingleton<ConnectivityCubit>(ConnectivityCubit(), dispose: (cubit) => cubit.close());
    _getIt.registerSingleton<AgentCubit>(
      AgentCubit(agentService: _getIt<AgentService>()),
      dispose: (cubit) => cubit.close(),
    );
    _getIt.registerSingleton<MapCubit>(MapCubit(mapService: _getIt<MapService>()), dispose: (cubit) => cubit.close());
    _getIt.registerSingleton<WeaponCubit>(
      WeaponCubit(weaponService: _getIt<WeaponService>()),
      dispose: (cubit) => cubit.close(),
    );
    _getIt.registerSingleton<RanksCubit>(
      RanksCubit(rankService: _getIt<RankService>()),
      dispose: (cubit) => cubit.close(),
    );
    _getIt.registerSingleton<ProfileCubit>(
      ProfileCubit(
        reviewService: _getIt<ReviewService>(),
        cacheManager: _getIt<CacheManager>(),
        onDataRefreshRequested: () {
          unawaited(_getIt<AgentCubit>().loadAgents());
          unawaited(_getIt<MapCubit>().loadMaps());
          unawaited(_getIt<WeaponCubit>().loadWeapons(forceRefresh: true));
          unawaited(_getIt<RanksCubit>().loadRanks(forceRefresh: true));
        },
      ),
      dispose: (cubit) => cubit.close(),
    );
  }

  // Getters
  ProductNetworkModel get networkModel => _getIt<ProductNetworkModel>();
  ThemeCubit get themeCubit => _getIt<ThemeCubit>();
  ConnectivityCubit get connectivityCubit => _getIt<ConnectivityCubit>();
  AgentCubit get agentCubit => _getIt<AgentCubit>();
  MapCubit get mapCubit => _getIt<MapCubit>();
  WeaponCubit get weaponCubit => _getIt<WeaponCubit>();
  RanksCubit get ranksCubit => _getIt<RanksCubit>();
  ProfileCubit get profileCubit => _getIt<ProfileCubit>();
}
