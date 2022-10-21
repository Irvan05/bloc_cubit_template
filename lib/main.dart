import 'package:bloc_cubit_template/basic_builder/basic_builder_page.dart';
import 'package:bloc_cubit_template/global/globals.dart';
import 'package:bloc_cubit_template/home_page.dart';
import 'package:bloc_cubit_template/global/my_router.dart';
import 'package:enough_platform_widgets/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoSnackApp(
        title: 'Flutter Demo',
        navigatorKey: navigatorKey,
        theme: const CupertinoThemeData(
          primaryColor: Colors.blue,
        ),
        // NORMAL ROUTE
        // initialRoute: HomePage.routeName,
        // routes: {
        //   '/': (context) => const HomePage(),
        //   HomePage.routeName: (context) => const HomePage(),
        //   BasicBuilderPage.routeName: (context) => BasicBuilderPage()
        // },

        //GENERATED ROUTE //MOST RECOMMENDED
        onGenerateRoute: MyRouter().onRoute);
  }
}
