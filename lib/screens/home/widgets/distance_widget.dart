import 'dart:math';
import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:mydistance/blocs/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DistanceWidget extends StatefulWidget {
  const DistanceWidget({Key key}) : super(key: key);

  @override
  _DistanceWidgetState createState() => _DistanceWidgetState();
}

class _DistanceWidgetState extends State<DistanceWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final dbReference = FirebaseDatabase.instance.reference();
  Query _Distance;
  Query _ref;
  String uid;
  double latitude;
  double longitude;
  String time;
  double lat1;
  double lon1;
  double lat2;
  double lon2;
  double lat0;
  double lon0;
  int i = 000;
  int dis = 100;
  int dis0 = 0;


  var alt = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _ref = FirebaseDatabase.instance.reference().child('UserLocations/');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  Widget _buildContactItem({Map distance}) {
    lat1 = latitude;
    lon1 = longitude;
    if (lat1 != null) {
      lat2 = distance['latitude'];
      lon2 = distance['longitude'];
      var r = 6371e3;
      var pi = 22 / 7;
      var la1 = lat1 * pi / 180;
      var la2 = lat2 * pi / 180;
      var p1 = (lat2 - lat1) * pi / 180;
      var p2 = (lon2 - lon1) * pi / 180;
      var a = sin(p1 / 2) * sin(p1 / 2) +
          cos(la1) * cos(la2) * sin(p2 / 2) * sin(p2 / 2);
      var c = 2 * atan2(sqrt(a), sqrt(1 - a));
      var d = (r * c);
      dis = d.toInt();

      if (dis < 3) {
        alt = 1;
        return Card(
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'There is another user ' +
                  dis.toString() +
                  ' meters away from you.',
              style: TextStyle(color: Colors.red),
            ),
          ) ,
        );
      } else if (dis > 3 && dis <= 5) {
        return Card(
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'There is another user ' +
                  dis.toString() +
                  ' meters away from you.',
              style: TextStyle(color: Colors.yellow),
            ),
          ) ,
        );
      } else if (dis>5 && dis<=10) {
        return Card(
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'There is another user ' +
                  dis.toString() +
                  ' meters away from you.',
              style: TextStyle(color: Colors.green),
            ),
          ) ,
        );
      } else {
        print('Debug : ' + distance.toString() + ' Distance : ' + dis.toString() + ' m.');
        return Container();
      }
      //print('Debug : ' + distance.toString() + ' Distance : ' + dis.toString() + ' m.');
    }
  }

  void showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        i=0;
        alt=0;
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Warning!",
        style: TextStyle(color: Colors.red),
      ),
      content: Text("Please social distancing."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final user = context.read<AuthBloc>().state.user;
    uid= user.uid;
    _Distance = FirebaseDatabase.instance
        .reference()
        .child('Distance/'+user.uid);
    if (alt == 1&&i==0) {
      //Todo alert
      i=1;
      print('alert'+i.toString());
      Future.delayed(Duration.zero, () => showAlertDialog(context));
    }
    print(i);
    BGLocation();
    return Container(
      height: screenHeight * .35,
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FirebaseAnimatedList(
            query: _Distance,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map distance = snapshot.value;
              return _buildContactItem(distance: distance);
            },
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  BGLocation() async {
    await BackgroundLocation.setAndroidNotification(
      title: 'Background service is running',
      message: 'Background location in progress',
      icon: '@mipmap/ic_launcher',
    );
    await BackgroundLocation.startLocationService();
    if (uid != null) {
      if (dbReference.child("UserLocations").child(uid).key.isNotEmpty !=
          true) {
        dbReference
            .child("UserLocations")
            .child(uid)
            .set({'latitude': latitude, 'longitude': longitude});
      } else {
        dbReference
            .child("UserLocations")
            .child(uid)
            .update({'latitude': latitude, 'longitude': longitude});
        dbReference
            .child("UserLocations")
            .once()
            .then((DataSnapshot snapshotl) {
          dbReference.child('Distance').child(uid).set(snapshotl.value);
          dbReference.child('Distance').child(uid).child(uid).remove();
        });
      }
      if (latitude != null) {
        lat0 = 13.716363;
        lon0 = 100.348394;
        var r = 6371e3;
        var pi = 22 / 7;
        var la1 = latitude * pi / 180;
        var la2 = lat0 * pi / 180;
        var p1 = (lat0 - latitude) * pi / 180;
        var p2 = (lon0 - longitude) * pi / 180;
        var a = sin(p1 / 2) * sin(p1 / 2) +
            cos(la1) * cos(la2) * sin(p2 / 2) * sin(p2 / 2);
        var c = 2 * atan2(sqrt(a), sqrt(1 - a));
        var d = (r * c);
        int dis0 = d.toInt();
        print('debug dis Thonburi University :' + dis0.toString());
        if (dis0 > 300) {
          dbReference.child('UserLocations').child(uid).remove();
          dbReference.child('Distance').child(uid).remove();
        }
      }
    }

    _ref = FirebaseDatabase.instance.reference().child('UserLocations/');

    BackgroundLocation.getLocationUpdates((location) {
      setState(() {
        this.latitude = location.latitude;
        this.longitude = location.longitude;
        this.time = DateTime.fromMillisecondsSinceEpoch(location.time.toInt())
            .toString();
      });
    });
  }
}
