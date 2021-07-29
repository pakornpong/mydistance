import 'package:mydistance/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/signup_cubit.dart';
import 'widgets/SignUpForm.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocProvider<SignupCubit>(
          create: (context) => SignupCubit(
            context.read<AuthenticationRepository>(),
          ),
          child: SingleChildScrollView(child: SignUpForm(formKey: _formKey)),
        ),
      ),
    );
  }
}
