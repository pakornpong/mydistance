

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:mydistance/blocs/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class RealtimeDatabase extends StatefulWidget {
  const RealtimeDatabase({Key key}) : super(key: key);

  @override
  _RealtimeDatabaseState createState() => _RealtimeDatabaseState();
}

class _RealtimeDatabaseState extends State<RealtimeDatabase> with SingleTickerProviderStateMixin {
   AnimationController _controller;

   Query _Distance;
   final databaseReference = FirebaseDatabase.instance.reference();


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _Distance = FirebaseDatabase.instance
        .reference()
        .child('Distance/YRNfgLva5zOdQ3aGNBUNY8HkDgw2/');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildContactItem({Map distance}) {
     print('distance ==> '+distance.toString());
     return Container(
       child: Card(
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               Text('latitude : '+distance['latitude'].toString()+', longitude : '+distance['longitude'].toString() ,),
             ],
           ),
         ),
       ),
     );
   }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthBloc>().state.user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Connect'),
      ),
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(user.uid),
              Container(
                height: 200,
                child: FirebaseAnimatedList(
                  query: _Distance,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    Map distance = snapshot.value;
                    return _buildContactItem(distance: distance);
                  },
                ),
              ),
            ],
          )), //center
    );
  }



}
