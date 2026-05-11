import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handbook_for_valorant/product/cubit/connectivity_state.dart';
import 'package:handbook_for_valorant/product/locator/base_cubit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> with BaseCubit<ConnectivityState> {
  ConnectivityCubit() : super(const ConnectivityState());

  StreamSubscription<InternetConnectionStatus>? _subscription;

  void init() {
    _subscription = InternetConnectionChecker.instance.onStatusChange.listen((status) {
      safeEmit(ConnectivityState(isConnected: status == InternetConnectionStatus.connected));
    });

    // Check initial status
    unawaited(
      InternetConnectionChecker.instance.hasConnection.then((connected) {
        safeEmit(ConnectivityState(isConnected: connected));
      }),
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
