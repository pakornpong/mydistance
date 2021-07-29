part of 'signup_cubit.dart';

enum SignupStatus { initial, submitting, success, error }

class SignupState extends Equatable {
  final String firstname;
  final String lastname;
  final String phone;
  final String email;
  final String password;
  final SignupStatus status;
  final String error;

  const SignupState({
    @required this.firstname,
    @required this.lastname,
    @required this.phone,
    @required this.email,
    @required this.password,
    @required this.status,
    @required this.error,
  });

  factory SignupState.initial() {
    return SignupState(
        firstname: '', lastname: '', phone: '', email: '', password: '', status: SignupStatus.initial, error: '');
  }

  @override
  List<Object> get props => [firstname, lastname, phone, email, password, status, error];

  SignupState copyWith({
    String firstname,
    String lastname,
    String phone,
    String email,
    String password,
    SignupStatus status,
    String error,
  }) {
    return SignupState(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
