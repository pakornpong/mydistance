import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDemoScreen extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Connect'),
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
            child: Text('Create'),
            onPressed: () {
              createRecord();
            },
          ),
          RaisedButton(
            child: Text('View'),
            onPressed: () {
              getData();
            },
          ),
          RaisedButton(
            child: Text('Udate'),
            onPressed: () {
              updateData();
            },
          ),
          RaisedButton(
            child: Text('Delete'),
            onPressed: () {
              deleteData();
            },
          ),
          
        ],
      )), //center
    );
  }

  void createRecord() {
    databaseReference
        .child("UserLocations").child("0001")
        .set({'latitude': '13.736717', 'longitude': '100.523186'});
    databaseReference
        .child("UserLocations").child("0002")
        .set({'latitude': '100.523186', 'longitude': '13.736717'});
  }

  void getData() {
    databaseReference.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }

  void updateData() {
    databaseReference.child("UserLocations").child("0001").update({'latitude': '0', 'longitude': '0'});
  }

  void deleteData() {
    databaseReference.child('UserLocations').remove();
  }


}