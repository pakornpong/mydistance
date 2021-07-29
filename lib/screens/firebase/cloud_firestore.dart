import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mydistance/blocs/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mydistance/repositories/auth/authentication_repository.dart';

class CloudFirestore extends StatefulWidget {
  @override
  _CloudFirestoreState createState() => _CloudFirestoreState();
}

class _CloudFirestoreState extends State<CloudFirestore>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  String documentId;
  final dbReference = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final user = context
        .read<AuthBloc>()
        .state
        .user;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.blue,),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Center(
            child: Text(
              'Profile',
              style: TextStyle(color: Colors.black),
            )),
        actions: [
          IconButton(
              icon: Icon(Icons.logout,color: Colors.blue,),
              onPressed: () {
                dbReference.child('UserLocations').child(user.uid).remove();
                dbReference.child('Distance').child(user.uid).remove();
                context.read<AuthenticationRepository>().logOut();
              }),
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: FutureBuilder<DocumentSnapshot>(
              future: users.doc(user.uid).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.hasData && !snapshot.data.exists) {
                  return Text("Document does not exist");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                  snapshot.data.data() as Map<String, dynamic>;
                  print(data.toString());
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * .03),
                      Container(
                          width: 190.0,
                          height: 190.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: new NetworkImage(
                                      "https://images.pexels.com/photos/556666/pexels-photo-556666.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940")
                              )
                          )),
                      SizedBox(height: screenHeight * .02),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(""),
                          ),
                          Expanded(
                            flex: 3,
                            child: TextButton(
                                onPressed: () {
                                  print("TextButton");
                                },
                                child: Text("Upload Image", style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),)
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Text("")
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * .02),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(
                                "UID",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                          ),
                          Expanded(
                              flex: 6,
                              child: Text(
                                  user.uid,
                                  style: TextStyle(fontSize: 16))
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * .02),
                      Divider(color: Colors.black,),
                      SizedBox(height: screenHeight * .02),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(
                                "First name",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                          ),
                          Expanded(
                              flex: 6,
                              child: Text("${data['firstname']}",
                                  style: TextStyle(fontSize: 16))
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * .02),
                      Divider(color: Colors.black,),
                      SizedBox(height: screenHeight * .02),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(
                                "Last name",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                          ),
                          Expanded(
                              flex: 6,
                              child: Text("${data['lastname']}",
                                  style: TextStyle(fontSize: 16))
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * .02),
                      Divider(color: Colors.black,),
                      SizedBox(height: screenHeight * .02),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(
                                "E-mail",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                          ),
                          Expanded(
                              flex: 6,
                              child: Text("${data['email']}",
                                  style: TextStyle(fontSize: 16))
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * .02),
                      Divider(color: Colors.black,),
                      SizedBox(height: screenHeight * .02),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(
                                "Phone",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                          ),
                          Expanded(
                              flex: 6,
                              child: Text("${data['phone']}",
                                  style: TextStyle(fontSize: 16))
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * .02),
                      Divider(color: Colors.black,),
                      SizedBox(height: screenHeight * .02),

                    ],
                  );
                //Text("Full Name: ${data['firstname']} ${data['lastname']}");
                }

                return Text("loading");
                },
            ),
          )),
    );
  }
}
