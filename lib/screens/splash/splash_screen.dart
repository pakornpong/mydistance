import 'package:mydistance/blocs/auth/bloc/auth_bloc.dart';
import 'package:mydistance/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          /*
          At first the status is unkown. When app loads status becomes authenticated or unauthenticated depending upon any user has logged in or not.
          */
          if (state.status == AuthStatus.unauthenticated) {
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WelcomeScreen(),
              ),
            );
          } else if (state.status == AuthStatus.authenticated) {
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          }
        },
        child: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
