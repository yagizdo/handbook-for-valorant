import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Internet connection check
  var connectivityResult = await (Connectivity().checkConnectivity());
  if(connectivityResult == ConnectivityResult.wifi) {
    print('internet connection wifi');
  } else if (connectivityResult == ConnectivityResult.none)
    {
      print('Internet connection none');
    }

    // Run app
  runApp(MyApp(internetInfo: connectivityResult,));
}