import 'package:bloc_cubit_template/basic_builder/counter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtherPageGenerated extends StatelessWidget {
  static const routeName = '/basic_builder/other_page_generated';
  const OtherPageGenerated({super.key});

  @override
  Widget build(BuildContext context) {
    final Counter myCounter = context.read<Counter>();
    return CupertinoPageScaffold(
      child: Center(
        child: Text(
          '${myCounter.state}',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
