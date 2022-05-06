import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class BookBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      print('$event');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print('onError $error');
    }
    super.onError(bloc, error, stackTrace);
  }
}
