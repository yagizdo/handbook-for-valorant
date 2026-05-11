import 'package:core/index.dart';
import 'package:handbook_for_valorant/features/ranks/model/competitive_tier_model.dart';
import 'package:handbook_for_valorant/features/ranks/model/rank_entity.dart';
import 'package:handbook_for_valorant/features/ranks/model/rank_mapper.dart';
import 'package:handbook_for_valorant/features/ranks/model/rank_model.dart';
import 'package:handbook_for_valorant/product/constants/api_endpoints.dart';
import 'package:handbook_for_valorant/product/network/product_network_model.dart';

class RankService {
  RankService({required ProductNetworkModel networkModel, required BaseRepository<RankEntity> repository})
    : _networkModel = networkModel,
      _repository = repository;
  final ProductNetworkModel _networkModel;
  final BaseRepository<RankEntity> _repository;

  Future<List<RankModel>> getRanks({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final cached = _repository.getAll();
      if (cached.isNotEmpty) {
        return cached.map((e) => e.toModel()).toList();
      }
    } else {
      _repository.deleteAll();
    }

    final result = await _networkModel.get<Map<String, dynamic>>(ApiEndpoints.competitiveTiers);

    return result.fold(
      onError: (error) {
        final cached = _repository.getAll();
        if (cached.isNotEmpty) {
          return cached.map((e) => e.toModel()).toList();
        }
        return [];
      },
      onSuccess: (data) {
        if (data == null || data['data'] == null) return [];

        final tiers = data['data'] as List;
        if (tiers.isEmpty) return [];

        final latestTier = CompetitiveTierModel.fromJson(tiers.last as Map<String, dynamic>);

        final ranks = latestTier.tiers
            .where((r) => r.tier != null && r.tier! > 0 && r.largeIcon != null && r.largeIcon!.isNotEmpty)
            .toList();

        _repository.deleteAll();
        for (final rank in ranks) {
          _repository.save(rank.toEntity());
        }

        return ranks;
      },
    );
  }

  void clearCache() => _repository.deleteAll();
}
