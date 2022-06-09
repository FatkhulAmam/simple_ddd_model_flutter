import 'package:flutter/material.dart';

import 'core/env.dart';

void main() => Production();

class Production extends Env {
  final String appName = 'Callink';
  final String baseUrl = 'https://api.callink.com'; //dev
  final String tnc = 'https://callink.com/tnc';
  final Color primarySwatch = Colors.teal;
  EnvType environmentType = EnvType.PRODUCTION;

  final String dbName = 'callink.db';
}

// import 'package:flutter/material.dart';
//
// import 'presentation/main_page.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MainPage(),
//     );
//   }
// }
