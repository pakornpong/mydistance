import 'package:mydistance/screens/signup/cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key key,
    @required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state.status == SignupStatus.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('${state.error}')),
            );
          context.read<SignupCubit>().reset();
          _formKey.currentState.reset();
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: screenHeight * .1),
            Text(
              "Create Account",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * .01),
            Text(
              "Sign up to get started!",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black.withOpacity(.6),
              ),
            ),
            SizedBox(height: screenHeight * .06),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'First Name',
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
                  context.read<SignupCubit>().firstnameChanged(value),
            ),
            SizedBox(height: screenHeight * .025),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Last Name',
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
                  context.read<SignupCubit>().lastnameChanged(value),
            ),
            SizedBox(height: screenHeight * .025),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Phone',
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
                  context.read<SignupCubit>().phoneChanged(value),
            ),
            SizedBox(height: screenHeight * .025),
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
              onChanged: (value) =>
                  context.read<SignupCubit>().emailChanged(value),
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
                  context.read<SignupCubit>().passwordChanged(value),
            ),
            SizedBox(height: screenHeight * .06),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  context.read<SignupCubit>().signupWithEmailAndPassword();
                }
              },
              child: const Text(
                'Sign Up',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: screenHeight * .02),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * .06,
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: RichText(
                text: TextSpan(
                  text: "I'm already a member, ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Sign In",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
