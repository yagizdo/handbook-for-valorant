import 'package:handbook_for_valorant/features/weapons/model/weapon_model.dart';
import 'package:handbook_for_valorant/features/weapons/model/weapons_response_model.dart';
import 'package:handbook_for_valorant/product/constants/api_endpoints.dart';
import 'package:handbook_for_valorant/product/network/product_network_model.dart';

class WeaponService {
  WeaponService({required ProductNetworkModel networkModel}) : _networkModel = networkModel;
  final ProductNetworkModel _networkModel;

  Future<List<WeaponModel>> getWeapons() async {
    final result = await _networkModel.get<Map<String, dynamic>>(ApiEndpoints.weapons);

    return result.fold(
      onError: (error) => [],
      onSuccess: (data) {
        if (data == null) return [];
        final weaponsResponseModel = WeaponsResponseModel.fromJson(data);
        if (weaponsResponseModel.weapons == null) return [];
        return weaponsResponseModel.weapons!;
      },
    );
  }
}
