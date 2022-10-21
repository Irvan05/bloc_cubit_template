import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<Map<String, dynamic>> {
  UserCubit() : super({'Name': '-', 'Age': 0});

  void setName(String newName) {
    return emit({'Name': newName, 'Age': state['Age']});
  }

  void setAge(int newAge) {
    return emit({'Name': state['Name'], 'Age': newAge});
  }
}
