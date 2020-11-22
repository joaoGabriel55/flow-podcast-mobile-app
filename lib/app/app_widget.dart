import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Modular.navigatorKey,
      title: 'Flow Pdc',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.orangeAccent
      ),
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
