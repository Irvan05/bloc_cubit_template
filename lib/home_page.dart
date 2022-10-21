import 'package:bloc_cubit_template/basic_builder/basic_builder_generated.dart';
import 'package:bloc_cubit_template/basic_builder/basic_builder_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'global/globals.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoButton(
            color: Colors.blue,
            child: const Text('Builder Example'),
            onPressed: () {
              Navigator.pushNamed(
                  navigatorKey.currentContext!, BasicBuilderPage.routeName);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CupertinoButton(
            color: Colors.blue,
            child: const Text('GENERATED Builder Example'),
            onPressed: () {
              Navigator.pushNamed(navigatorKey.currentContext!,
                  BasicBuilderGenerated.routeName);
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }
}
