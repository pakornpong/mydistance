import 'package:bloc/bloc.dart';
import 'package:mydistance/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthenticationRepository _authenticationRepository;

  SignupCubit(AuthenticationRepository authenticationRepository)
      : _authenticationRepository = authenticationRepository,
        super(SignupState.initial());

  void reset() {
    emit(SignupState.initial());
  }

  void firstnameChanged(String value) {
    emit(state.copyWith(firstname: value));
  }

  void lastnameChanged(String value) {
    emit(state.copyWith(lastname: value));
  }

  void emailChanged(String value) {
    emit(state.copyWith(email: value));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value));
  }

  void phoneChanged(String value) {
    emit(state.copyWith(phone: value));
  }

  Future<void> signupWithEmailAndPassword() async {
    if (state.email.isEmpty ||
        state.password.isEmpty||
        state.firstname.isEmpty||
        state.lastname.isEmpty||
        state.phone.isEmpty) return;
    emit(state.copyWith(status: SignupStatus.submitting));
    try {
      await _authenticationRepository.signUpWithEmailAndPassword(
        email: state.email,
        password: state.password,
        firstname: state.firstname,
        lastname: state.lastname,
        phone: state.phone,
      );
      emit(state.copyWith(status: SignupStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SignupStatus.error, error: e.message));
    }
  }
}
