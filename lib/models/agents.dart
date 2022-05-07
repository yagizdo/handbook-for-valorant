// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Agents agentsFromJson(String str) => Agents.fromJson(json.decode(str));

String agentsToJson(Agents data) => json.encode(data.toJson());

class Agents {
  Agents({
    required this.status,
    required this.data,
  });

  int status;
  Data data;

  factory Agents.fromJson(Map<String, dynamic> json) => Agents(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.uuid,
    required this.displayName,
    required this.description,
    required this.developerName,
    required this.displayIcon,
    required this.displayIconSmall,
    required this.bustPortrait,
    required this.fullPortrait,
    required this.fullPortraitV2,
    required this.killfeedPortrait,
    required this.isFullPortraitRightFacing,
    required this.isPlayableCharacter,
    required this.isAvailableForTest,
    required this.isBaseContent,
    required this.role,
    required this.abilities,
    required this.voiceLine,
  });

  String uuid;
  String displayName;
  String description;
  String developerName;
  String displayIcon;
  String displayIconSmall;
  String bustPortrait;
  String fullPortrait;
  String fullPortraitV2;
  String killfeedPortrait;
  bool isFullPortraitRightFacing;
  bool isPlayableCharacter;
  bool isAvailableForTest;
  bool isBaseContent;
  Role role;
  List<Ability> abilities;
  VoiceLine voiceLine;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    uuid: json["uuid"],
    displayName: json["displayName"],
    description: json["description"],
    developerName: json["developerName"],
    displayIcon: json["displayIcon"],
    displayIconSmall: json["displayIconSmall"],
    bustPortrait: json["bustPortrait"],
    fullPortrait: json["fullPortrait"],
    fullPortraitV2: json["fullPortraitV2"],
    killfeedPortrait: json["killfeedPortrait"],
    isFullPortraitRightFacing: json["isFullPortraitRightFacing"],
    isPlayableCharacter: json["isPlayableCharacter"],
    isAvailableForTest: json["isAvailableForTest"],
    isBaseContent: json["isBaseContent"],
    role: Role.fromJson(json["role"]),
    abilities: List<Ability>.from(json["abilities"].map((x) => Ability.fromJson(x))),
    voiceLine: VoiceLine.fromJson(json["voiceLine"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "displayName": displayName,
    "description": description,
    "developerName": developerName,
    "displayIcon": displayIcon,
    "displayIconSmall": displayIconSmall,
    "bustPortrait": bustPortrait,
    "fullPortrait": fullPortrait,
    "fullPortraitV2": fullPortraitV2,
    "killfeedPortrait": killfeedPortrait,
    "isFullPortraitRightFacing": isFullPortraitRightFacing,
    "isPlayableCharacter": isPlayableCharacter,
    "isAvailableForTest": isAvailableForTest,
    "isBaseContent": isBaseContent,
    "role": role.toJson(),
    "abilities": List<dynamic>.from(abilities.map((x) => x.toJson())),
    "voiceLine": voiceLine.toJson(),
  };
}

class Ability {
  Ability({
    required this.slot,
    required this.displayName,
    required this.description,
    required this.displayIcon,
  });

  String slot;
  String displayName;
  String description;
  String displayIcon;

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
    slot: json["slot"],
    displayName: json["displayName"],
    description: json["description"],
    displayIcon: json["displayIcon"],
  );

  Map<String, dynamic> toJson() => {
    "slot": slot,
    "displayName": displayName,
    "description": description,
    "displayIcon": displayIcon,
  };
}

class Role {
  Role({
    required this.uuid,
    required this.displayName,
    required this.description,
    required this.displayIcon,
    required this.assetPath,
  });

  String uuid;
  String displayName;
  String description;
  String displayIcon;
  String assetPath;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    uuid: json["uuid"],
    displayName: json["displayName"],
    description: json["description"],
    displayIcon: json["displayIcon"],
    assetPath: json["assetPath"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "displayName": displayName,
    "description": description,
    "displayIcon": displayIcon,
    "assetPath": assetPath,
  };
}

class VoiceLine {
  VoiceLine({
    required this.minDuration,
    required this.maxDuration,
    required this.mediaList,
  });

  double minDuration;
  double maxDuration;
  List<MediaList> mediaList;

  factory VoiceLine.fromJson(Map<String, dynamic> json) => VoiceLine(
    minDuration: json["minDuration"].toDouble(),
    maxDuration: json["maxDuration"].toDouble(),
    mediaList: List<MediaList>.from(json["mediaList"].map((x) => MediaList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "minDuration": minDuration,
    "maxDuration": maxDuration,
    "mediaList": List<dynamic>.from(mediaList.map((x) => x.toJson())),
  };
}

class MediaList {
  MediaList({
    required this.id,
    required this.wwise,
    required this.wave,
  });

  int id;
  String wwise;
  String wave;

  factory MediaList.fromJson(Map<String, dynamic> json) => MediaList(
    id: json["id"],
    wwise: json["wwise"],
    wave: json["wave"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "wwise": wwise,
    "wave": wave,
  };
}
