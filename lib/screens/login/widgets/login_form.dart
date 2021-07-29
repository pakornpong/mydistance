import 'package:mydistance/screens/login/cubit/login_cubit.dart';
import 'package:mydistance/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key key,
    @required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('${state.error}')),
            );
          context.read<LoginCubit>().reset();
          _formKey.currentState.reset();
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: screenHeight * .12),
            Text(
              "Welcome,",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * .01),
            Text(
              "Sign in to continue!",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black.withOpacity(.6),
              ),
            ),
            SizedBox(height: screenHeight * .12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'E-mail',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value.trim().isEmpty) {
                  return 'Cannot be empty';
                }
                return null;
              },
              onChanged: (value) => context.read<LoginCubit>().emailChanged(value),
            ),
            SizedBox(height: screenHeight * .025),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value.trim().isEmpty) {
                  return 'Cannot be empty';
                }
                return null;
              },
              onChanged: (value) =>
                  context.read<LoginCubit>().passwordChanged(value),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox( height: screenHeight * .075,),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  context.read<LoginCubit>().logInWithCredentials();
                }
              },
              child: const Text('Sign In',
                style: TextStyle(fontSize: 16),

              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: screenHeight * .02),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: screenHeight * .15,),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpPage(),
                  ),
                );
              },
              child: RichText(
                text: TextSpan(
                  text: "I'm a new user, ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Sign Up",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
