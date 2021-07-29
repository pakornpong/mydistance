import 'package:bloc/bloc.dart';
import 'package:mydistance/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginCubit(AuthenticationRepository authenticationRepository)
      : _authenticationRepository = authenticationRepository,
        super(LoginState.initial());

  void reset() {
    emit(LoginState.initial());
  }

  void emailChanged(String value) {
    emit(state.copyWith(email: value));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value));
  }

  Future<void> logInWithCredentials() async {
    if (state.email.isEmpty || state.password.isEmpty) return;
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      await _authenticationRepository.loginWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.error, error: e.message));
    }
  }
}
