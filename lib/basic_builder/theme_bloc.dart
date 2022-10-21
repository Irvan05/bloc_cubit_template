import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Cubit<bool> {
  ThemeBloc() : super(false);

  @override
  void onChange(Change<bool> change) {
    super.onChange(change);
    print(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print(error);
  }

  void switchTheme() => emit(!state);
}
