part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class ClientListShown extends RegisterEvent {}

class DireccionListShown extends RegisterEvent {}

class RegisterNewUser extends RegisterEvent {
  final String name;
  final String lastName;
  final String email;
  final String password;
  final int idRol;

  const RegisterNewUser({
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
    required this.idRol,
  });
}

class RegisterUserUpdated extends RegisterEvent {
  final String name;
  final String lastName;
  final String email;
  final String password;
  final int idRol;
  final int id;

  const RegisterUserUpdated({
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
    required this.idRol,
    required this.id,
  });
}
