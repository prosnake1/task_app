import 'package:flutter/material.dart';
import 'package:task_app/router.dart';
import 'package:task_app/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: router);
  }
}
