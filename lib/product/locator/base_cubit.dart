import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handbook_for_valorant/product/locator/base_container.dart';
import 'package:handbook_for_valorant/product/network/product_network_model.dart';

mixin BaseCubit<T> on Cubit<T> {
  ProductNetworkModel get networkModel => BaseContainer.instance.networkModel;

  /// Emits [state] only if this cubit has not been closed.
  /// Use after async gaps where the cubit may have been disposed.
  void safeEmit(T state) {
    if (isClosed) return;
    emit(state);
  }
}
