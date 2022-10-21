import 'package:flutter_bloc/flutter_bloc.dart';

class Counter extends Cubit<int> {
  Counter({required this.init}) : super(init);

  int init;

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print(error);
  }

  void increment() => emit(state + 1);

  void dencrement() => emit(state - 1);
}
