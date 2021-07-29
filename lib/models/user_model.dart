import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class User extends Equatable {
  final String email;
  final String id;
  final String photo;
  final String firstname;
  final String lastname;
  final String phone;

  const User({
    @required this.email,
    @required this.id,
    @required this.photo,
    @required this.firstname,
    @required this.lastname,
    @required this.phone,
  });

  //* It's useful to define a static empty User so that we don't have to handle null Users and can always work with a concrete User object.
  static const empty = User(email: '', id: '', photo: '', firstname: '',lastname: '',phone: '');

  //* Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  //* Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object> get props => [email, id, photo, firstname, lastname, phone];
}
