import 'package:core/logger/product_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBlocObserver extends BlocObserver {
  static const _cubitsWithCustomLogging = {'ThemeCubit'};

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (_cubitsWithCustomLogging.contains(bloc.runtimeType.toString())) return;
    ProductLogger.d(
      '${change.currentState.runtimeType} -> ${change.nextState.runtimeType}',
      tag: bloc.runtimeType.toString(),
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    ProductLogger.e('Bloc error occurred', tag: bloc.runtimeType.toString(), error: error, stackTrace: stackTrace);
  }
}
