import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Core extends StatefulWidget {
  Core({Key key}) : super(key: key);

  @override
  _CoreState createState() => _CoreState();
}

class _CoreState extends State<Core> {

  String get name => 'mydistance';

  FirebaseOptions get firebaseOptions => const FirebaseOptions(
      apiKey: "AIzaSyAH8JxWfyQM-m3F19Gp5lGrAyjATVrTmkE",
      authDomain: "project-my-distance.firebaseapp.com",
      databaseURL: "https://project-my-distance.firebaseio.com",
      projectId: "project-my-distance",
      storageBucket: "project-my-distance.appspot.com",
      messagingSenderId: "620359094039",
      appId: "1:620359094039:web:8c0e2c0a15c9a73ee67152",
      measurementId: "G-LX71WCWLYB"
  );

  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp();
    assert(app != null);
    print('Initialized default app $app');
  }

  Future<void> initializeSecondary() async {
    FirebaseApp app =
    await Firebase.initializeApp(name: name, options: firebaseOptions);

    assert(app != null);
    print('Initialized $app');
  }

  void apps() {
    final List<FirebaseApp> apps = Firebase.apps;
    print('Currently initialized apps: $apps');
  }

  void options() {
    final FirebaseApp app = Firebase.app(name);
    final FirebaseOptions options = app?.options;
    print('Current options for app $name: $options');
  }

  Future<void> delete() async {
    final FirebaseApp app = Firebase.app(name);
    await app?.delete();
    print('App $name deleted');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Core example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                  onPressed: initializeDefault,
                  child: const Text('Initialize default app')),
              ElevatedButton(
                  onPressed: initializeSecondary,
                  child: const Text('Initialize secondary app')),
              ElevatedButton(onPressed: apps, child: const Text('Get apps')),
              ElevatedButton(
                  onPressed: options, child: const Text('List options')),
              ElevatedButton(
                  onPressed: delete, child: const Text('Delete app')),
            ],
          ),
        ),
      ),
    );
  }
}