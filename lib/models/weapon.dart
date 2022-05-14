class Weapon {
  String? uuid;
  String? displayName;
  String? category;
  String? defaultSkinUuid;
  String? displayIcon;
  String? killStreamIcon;
  String? assetPath;
  WeaponStats? weaponStats;
  ShopData? shopData;

  Weapon(
      {this.uuid,
        this.displayName,
        this.category,
        this.defaultSkinUuid,
        this.displayIcon,
        this.killStreamIcon,
        this.assetPath,
        this.weaponStats,
        this.shopData});

  Weapon.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    displayName = json['displayName'];
    category = json['category'];
    defaultSkinUuid = json['defaultSkinUuid'];
    displayIcon = json['displayIcon'];
    killStreamIcon = json['killStreamIcon'];
    assetPath = json['assetPath'];
    weaponStats = json['weaponStats'] != null
        ? new WeaponStats.fromJson(json['weaponStats'])
        : null;
    shopData = json['shopData'] != null
        ? new ShopData.fromJson(json['shopData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['displayName'] = this.displayName;
    data['category'] = this.category;
    data['defaultSkinUuid'] = this.defaultSkinUuid;
    data['displayIcon'] = this.displayIcon;
    data['killStreamIcon'] = this.killStreamIcon;
    data['assetPath'] = this.assetPath;
    if (this.weaponStats != null) {
      data['weaponStats'] = this.weaponStats!.toJson();
    }
    if (this.shopData != null) {
      data['shopData'] = this.shopData!.toJson();
    }
    return data;
  }
}

class WeaponStats {
  double? fireRate;
  int? magazineSize;
  double? runSpeedMultiplier;
  double? equipTimeSeconds;
  double? reloadTimeSeconds;
  double? firstBulletAccuracy;
  int? shotgunPelletCount;
  String? wallPenetration;
  String? feature;
  String? fireMode;
  String? altFireType;
  AdsStats? adsStats;
  AltShotgunStats? altShotgunStats;
  AirBurstStats? airBurstStats;
  List<DamageRanges>? damageRanges;

  WeaponStats(
      {this.fireRate,
        this.magazineSize,
        this.runSpeedMultiplier,
        this.equipTimeSeconds,
        this.reloadTimeSeconds,
        this.firstBulletAccuracy,
        this.shotgunPelletCount,
        this.wallPenetration,
        this.feature,
        this.fireMode,
        this.altFireType,
        this.adsStats,
        this.altShotgunStats,
        this.airBurstStats,
        this.damageRanges});

  WeaponStats.fromJson(Map<String, dynamic> json) {
    fireRate = json['fireRate'];
    magazineSize = json['magazineSize'];
    runSpeedMultiplier = json['runSpeedMultiplier'];
    equipTimeSeconds = json['equipTimeSeconds'];
    reloadTimeSeconds = json['reloadTimeSeconds'];
    firstBulletAccuracy = json['firstBulletAccuracy'];
    shotgunPelletCount = json['shotgunPelletCount'];
    wallPenetration = json['wallPenetration'];
    feature = json['feature'];
    fireMode = json['fireMode'];
    altFireType = json['altFireType'];
    adsStats = json['adsStats'] != null
        ? new AdsStats.fromJson(json['adsStats'])
        : null;
    altShotgunStats = json['altShotgunStats'] != null
        ? new AltShotgunStats.fromJson(json['altShotgunStats'])
        : null;
    airBurstStats = json['airBurstStats'] != null
        ? new AirBurstStats.fromJson(json['airBurstStats'])
        : null;
    if (json['damageRanges'] != null) {
      damageRanges = <DamageRanges>[];
      json['damageRanges'].forEach((v) {
        damageRanges!.add(new DamageRanges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fireRate'] = this.fireRate;
    data['magazineSize'] = this.magazineSize;
    data['runSpeedMultiplier'] = this.runSpeedMultiplier;
    data['equipTimeSeconds'] = this.equipTimeSeconds;
    data['reloadTimeSeconds'] = this.reloadTimeSeconds;
    data['firstBulletAccuracy'] = this.firstBulletAccuracy;
    data['shotgunPelletCount'] = this.shotgunPelletCount;
    data['wallPenetration'] = this.wallPenetration;
    data['feature'] = this.feature;
    data['fireMode'] = this.fireMode;
    data['altFireType'] = this.altFireType;
    if (this.adsStats != null) {
      data['adsStats'] = this.adsStats!.toJson();
    }
    if (this.altShotgunStats != null) {
      data['altShotgunStats'] = this.altShotgunStats!.toJson();
    }
    if (this.airBurstStats != null) {
      data['airBurstStats'] = this.airBurstStats!.toJson();
    }
    if (this.damageRanges != null) {
      data['damageRanges'] = this.damageRanges!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdsStats {
  double? zoomMultiplier;
  double? fireRate;
  double? runSpeedMultiplier;
  int? burstCount;
  double? firstBulletAccuracy;

  AdsStats(
      {this.zoomMultiplier,
        this.fireRate,
        this.runSpeedMultiplier,
        this.burstCount,
        this.firstBulletAccuracy});

  AdsStats.fromJson(Map<String, dynamic> json) {
    zoomMultiplier = json['zoomMultiplier'];
    fireRate = json['fireRate'];
    runSpeedMultiplier = json['runSpeedMultiplier'];
    burstCount = json['burstCount'];
    firstBulletAccuracy = json['firstBulletAccuracy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['zoomMultiplier'] = this.zoomMultiplier;
    data['fireRate'] = this.fireRate;
    data['runSpeedMultiplier'] = this.runSpeedMultiplier;
    data['burstCount'] = this.burstCount;
    data['firstBulletAccuracy'] = this.firstBulletAccuracy;
    return data;
  }
}

class AltShotgunStats {
  int? shotgunPelletCount;
  double? burstRate;

  AltShotgunStats({this.shotgunPelletCount, this.burstRate});

  AltShotgunStats.fromJson(Map<String, dynamic> json) {
    shotgunPelletCount = json['shotgunPelletCount'];
    burstRate = json['burstRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shotgunPelletCount'] = this.shotgunPelletCount;
    data['burstRate'] = this.burstRate;
    return data;
  }
}

class AirBurstStats {
  int? shotgunPelletCount;
  double? burstDistance;

  AirBurstStats({this.shotgunPelletCount, this.burstDistance});

  AirBurstStats.fromJson(Map<String, dynamic> json) {
    shotgunPelletCount = json['shotgunPelletCount'];
    burstDistance = json['burstDistance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shotgunPelletCount'] = this.shotgunPelletCount;
    data['burstDistance'] = this.burstDistance;
    return data;
  }
}

class DamageRanges {
  int? rangeStartMeters;
  int? rangeEndMeters;
  double? headDamage;
  int? bodyDamage;
  double? legDamage;

  DamageRanges(
      {this.rangeStartMeters,
        this.rangeEndMeters,
        this.headDamage,
        this.bodyDamage,
        this.legDamage});

  DamageRanges.fromJson(Map<String, dynamic> json) {
    rangeStartMeters = json['rangeStartMeters'];
    rangeEndMeters = json['rangeEndMeters'];
    headDamage = json['headDamage'];
    bodyDamage = json['bodyDamage'];
    legDamage = json['legDamage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rangeStartMeters'] = this.rangeStartMeters;
    data['rangeEndMeters'] = this.rangeEndMeters;
    data['headDamage'] = this.headDamage;
    data['bodyDamage'] = this.bodyDamage;
    data['legDamage'] = this.legDamage;
    return data;
  }
}

class ShopData {
  int? cost;
  String? category;
  String? categoryText;
  GridPosition? gridPosition;
  bool? canBeTrashed;
  Null? image;
  String? newImage;
  Null? newImage2;
  String? assetPath;

  ShopData(
      {this.cost,
        this.category,
        this.categoryText,
        this.gridPosition,
        this.canBeTrashed,
        this.image,
        this.newImage,
        this.newImage2,
        this.assetPath});

  ShopData.fromJson(Map<String, dynamic> json) {
    cost = json['cost'];
    category = json['category'];
    categoryText = json['categoryText'];
    gridPosition = json['gridPosition'] != null
        ? new GridPosition.fromJson(json['gridPosition'])
        : null;
    canBeTrashed = json['canBeTrashed'];
    image = json['image'];
    newImage = json['newImage'];
    newImage2 = json['newImage2'];
    assetPath = json['assetPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cost'] = this.cost;
    data['category'] = this.category;
    data['categoryText'] = this.categoryText;
    if (this.gridPosition != null) {
      data['gridPosition'] = this.gridPosition!.toJson();
    }
    data['canBeTrashed'] = this.canBeTrashed;
    data['image'] = this.image;
    data['newImage'] = this.newImage;
    data['newImage2'] = this.newImage2;
    data['assetPath'] = this.assetPath;
    return data;
  }
}

class GridPosition {
  int? row;
  int? column;

  GridPosition({this.row, this.column});

  GridPosition.fromJson(Map<String, dynamic> json) {
    row = json['row'];
    column = json['column'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['row'] = this.row;
    data['column'] = this.column;
    return data;
  }
}
