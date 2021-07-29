
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:mydistance/screens/firebase/core.dart';
import 'package:mydistance/screens/firebase/realtimedb.dart';
/// Returns a [MaterialApp].
class Menu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
          body: Body(),
        ));
  }
}

/// Provides a UI to select a authentication type page
class Body extends StatelessWidget {
  Query _ref;
  @override
  // Navigates to a new page
  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    _ref = FirebaseDatabase.instance
        .reference()
        .child('Distance/');
    Widget _buildContactItem({Map distance}) {
      print(distance);
      return Container(
        child: Column(
          children: [
            Text(distance.toString()),
            // Text(distance['latitude'],),
            // Text(distance['longitude'],),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("HergApp"),
      ),
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: <Widget>[
      //     Container(
      //       child: ElevatedButton(
      //         child : Text( 'Core'),
      //         onPressed: () => _pushPage(context, Core()),
      //       ),
      //       padding: const EdgeInsets.all(5),
      //       alignment: Alignment.center,
      //     ),
      //     Container(
      //       child: ElevatedButton(
      //         child : Text( 'realtimedb'),
      //         onPressed: () => _pushPage(context, FirebaseDemoScreen()),
      //       ),
      //       padding: const EdgeInsets.all(5),
      //       alignment: Alignment.center,
      //     ),
      //     Container(
      //       child: ElevatedButton(
      //         onPressed: () {  },
      //         child : Text( 'Registration'),
      //         // onPressed: () => _pushPage(context, RegisterPage()),
      //       ),
      //       padding: const EdgeInsets.all(5),
      //       alignment: Alignment.center,
      //     ),
      //
      //   ],
      // ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map distance = snapshot.value;
            return _buildContactItem(distance: distance);
          },
        ),
      ),
    );
  }
}
