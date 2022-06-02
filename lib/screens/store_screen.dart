import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:valorant_client/valorant_client.dart';
import 'package:valorant_tips/network/api_client.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  late ValorantClient client;
  late final currentPlayer;
  late final currentStore;
  late final listexp;

  Future getPlayer() async {
    client = ValorantClient(
      UserDetails(
          userName: 'frdevx', password: '@20Valo21?=', region: Region.eu),
      callback: Callback(
        onError: (String error) {
          print(error);
        },
        onRequestError: (DioError error) {
          print(error.message);
        },
      ),
    );
    await client.init(true);
    final player = client.playerInterface.getStorefront();
    await player.then((value) => listexp = value?.skinsPanelLayout?.singleItemOffers);
    for (var w in listexp) {
      var response = ApiClient().dio.get('https://valorant-api.com/v1/weapons/skinlevels/${w}');
      print(response);
    }
  }

  @override
  void initState() {
    super.initState();
    getPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
