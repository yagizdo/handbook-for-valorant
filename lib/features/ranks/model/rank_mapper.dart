import 'package:handbook_for_valorant/features/ranks/model/rank_entity.dart';
import 'package:handbook_for_valorant/features/ranks/model/rank_model.dart';

extension RankModelToEntity on RankModel {
  RankEntity toEntity() {
    return RankEntity(
      tier: tier ?? 0,
      tierName: tierName,
      division: division,
      divisionName: divisionName,
      color: color,
      backgroundColor: backgroundColor,
      smallIcon: smallIcon,
      largeIcon: largeIcon,
      rankTriangleDownIcon: rankTriangleDownIcon,
      rankTriangleUpIcon: rankTriangleUpIcon,
    );
  }
}

extension RankEntityToModel on RankEntity {
  RankModel toModel() {
    return RankModel(
      tier: tier,
      tierName: tierName,
      division: division,
      divisionName: divisionName,
      color: color,
      backgroundColor: backgroundColor,
      smallIcon: smallIcon,
      largeIcon: largeIcon,
      rankTriangleDownIcon: rankTriangleDownIcon,
      rankTriangleUpIcon: rankTriangleUpIcon,
    );
  }
}
