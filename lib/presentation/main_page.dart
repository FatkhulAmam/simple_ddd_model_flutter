import 'dart:developer';

import 'package:flutter/material.dart';
import '../application/services.dart';

import '../infrastructure/person.dart';
import './person_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Person? person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dio Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              person != null
                  ? PersonCard(person: person!)
                  : const Text('no data'),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () async {
                    Person? result = await Services.getById(2);
                    if (result != null) {
                      setState(() {
                        person = result;
                      });
                    }
                  },
                  child: const Text('GET'),
                ),
              ),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                    onPressed: () async {
                      Person? result = await Services.createUser(
                          'diorama', 'senja', 'dioramaSenja@reg.res');
                      if (result != null) {
                        setState(() {
                          person = result;
                        });
                      }
                    },
                    child: const Text('POST')),
              )
            ],
          ),
        ));
  }
}
