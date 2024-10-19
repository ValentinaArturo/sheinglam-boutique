part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterNewUser extends RegisterEvent {
  final String name;
  final String email;
  final String password;

  const RegisterNewUser({
    required this.name,
    required this.email,
    required this.password,
  });
}