part of 'register_bloc.dart';

abstract class RegisterState extends BaseState {}

class RegisterInitial extends RegisterState {}

class RegisterInProgress extends RegisterState {}

class RegisterUserSuccess extends RegisterState {}

class RegisterError extends RegisterState {
  final String message;

  RegisterError({
    required this.message,
  });
}
