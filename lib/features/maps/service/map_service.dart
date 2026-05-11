import 'package:handbook_for_valorant/features/maps/model/map_model.dart';
import 'package:handbook_for_valorant/features/maps/model/maps_response_model.dart';
import 'package:handbook_for_valorant/product/constants/api_endpoints.dart';
import 'package:handbook_for_valorant/product/network/product_network_model.dart';

class MapService {
  MapService({required ProductNetworkModel networkModel}) : _networkModel = networkModel;
  final ProductNetworkModel _networkModel;

  Future<List<MapModel>> getMaps() async {
    final result = await _networkModel.get<Map<String, dynamic>>(ApiEndpoints.maps);

    return result.fold(
      onError: (error) => [],
      onSuccess: (data) {
        if (data == null) return [];
        final response = MapsResponseModel.fromJson(data);
        return response.maps ?? <MapModel>[];
      },
    );
  }
}
