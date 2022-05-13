import 'package:meta/meta.dart';
import 'dart:convert';


class Rank {
  Rank({
    required this.uuid,
    required this.assetObjectName,
    required this.tiers,
    required this.assetPath,
  });

  String uuid;
  String assetObjectName;
  List<Tier> tiers;
  String assetPath;

  factory Rank.fromJson(Map<String, dynamic> json) => Rank(
    uuid: json["uuid"],
    assetObjectName: json["assetObjectName"],
    tiers: List<Tier>.from(json["tiers"].map((x) => Tier.fromJson(x))),
    assetPath: json["assetPath"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "assetObjectName": assetObjectName,
    "tiers": List<dynamic>.from(tiers.map((x) => x.toJson())),
    "assetPath": assetPath,
  };
}

class Tier {
  Tier({
    required this.tier,
    required this.tierName,
    required this.division,
    required this.divisionName,
    required this.color,
    required this.backgroundColor,
    required this.smallIcon,
    required this.largeIcon,
    required this.rankTriangleDownIcon,
    required this.rankTriangleUpIcon,
  });

  int tier;
  String tierName;
  String division;
  String divisionName;
  String color;
  String backgroundColor;
  String smallIcon;
  String largeIcon;
  String rankTriangleDownIcon;
  String rankTriangleUpIcon;

  factory Tier.fromJson(Map<String, dynamic> json) => Tier(
    tier: json["tier"],
    tierName: json["tierName"],
    division: json["division"],
    divisionName: json["divisionName"],
    color: json["color"],
    backgroundColor: json["backgroundColor"],
    smallIcon: json["smallIcon"] == null ? null : json["smallIcon"],
    largeIcon: json["largeIcon"] == null ? null : json["largeIcon"],
    rankTriangleDownIcon: json["rankTriangleDownIcon"] == null ? null : json["rankTriangleDownIcon"],
    rankTriangleUpIcon: json["rankTriangleUpIcon"] == null ? null : json["rankTriangleUpIcon"],
  );

  Map<String, dynamic> toJson() => {
    "tier": tier,
    "tierName": tierName,
    "division": division,
    "divisionName": divisionName,
    "color": color,
    "backgroundColor": backgroundColor,
    "smallIcon": smallIcon == null ? null : smallIcon,
    "largeIcon": largeIcon == null ? null : largeIcon,
    "rankTriangleDownIcon": rankTriangleDownIcon == null ? null : rankTriangleDownIcon,
    "rankTriangleUpIcon": rankTriangleUpIcon == null ? null : rankTriangleUpIcon,
  };
}
