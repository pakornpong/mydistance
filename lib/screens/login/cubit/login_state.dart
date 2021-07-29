part of 'login_cubit.dart';

enum LoginStatus { initial, submitting, success, error }

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus status;
  final String error;

  const LoginState({
    @required this.email,
    @required this.password,
    @required this.status,
    @required this.error,
  });

  factory LoginState.initial() {
    return LoginState(
        email: '', password: '', status: LoginStatus.initial, error: '');
  }

  @override
  List<Object> get props => [email, password, status, error];

  LoginState copyWith({
    String email,
    String password,
    LoginStatus status,
    String error,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
