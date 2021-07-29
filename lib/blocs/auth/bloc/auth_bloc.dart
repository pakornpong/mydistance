import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mydistance/repositories/auth/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository _authRepository;
  StreamSubscription<firebase_auth.User> _userSubscription;

  AuthBloc({@required AuthenticationRepository authenticationRepository})
      : _authRepository = authenticationRepository,
        super(AuthState.unknown()) {
    _userSubscription = _authRepository.user.listen((user) {
      add(AuthUserChanged(user: user));
    });
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthUserChanged) {
      yield* _mapAuthUserChangedToState(event);
    }
    if (event is AuthUserLogOut) {
      await _authRepository.logOut();
    }
  }

  Stream<AuthState> _mapAuthUserChangedToState(AuthUserChanged event) async* {
    yield event.user != null
        ? AuthState.aunthenticated(user: event.user)
        : AuthState.unauthenticated();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
