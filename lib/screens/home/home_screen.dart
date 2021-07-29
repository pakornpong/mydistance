import 'package:mydistance/blocs/auth/bloc/auth_bloc.dart';
import 'package:mydistance/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mydistance/screens/firebase/cloud_firestore.dart';
import 'package:mydistance/screens/home/widgets/distance_widget.dart';

import 'package:mydistance/screens/home/widgets/map_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final user = context.read<AuthBloc>().state.user;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
                'Home',
                style: TextStyle(color: Colors.black),
              )),
          actions: [
            IconButton(
                icon: Icon(Icons.person,color: Colors.blue,),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CloudFirestore()),
                  );
                }),
          ],
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              SizedBox(height: screenHeight * .01),
              MapWidget(),
              SizedBox(height: screenHeight * .01),
              DistanceWidget(),

            ],
          ),
        ),
      ),
    );
  }
}
