part of 'login_bloc.dart';

abstract class LoginState extends BaseState {}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginReminderMailSuccess extends LoginState {
  final String reminderMail;

  LoginReminderMailSuccess({
    required this.reminderMail,
  });
}

class LoginError extends LoginState {
  final String error;

  LoginError({
    required this.error,
  });
}
