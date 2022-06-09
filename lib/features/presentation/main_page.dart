import 'dart:developer';

import 'package:dio_demo/features/infrastructure/models/main_response.dart';
import 'package:flutter/material.dart';
import '../application/main_services.dart';

import '../presentation/person_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainResponse? mainResponse;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
