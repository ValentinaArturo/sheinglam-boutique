part of 'recover_bloc.dart';

abstract class RecoverEvent extends Equatable {
  const RecoverEvent();

  @override
  List<Object> get props => [];
}

class PinSent extends RecoverEvent {
  final String email;

  const PinSent({
    required this.email,
  });
}

class PinValidated extends RecoverEvent {
  final String pin;
  final String email;

  const PinValidated({
    required this.pin,
    required this.email,
  });
}

class UserUpdatedPassword extends RecoverEvent {
  final String email;
  final String password;

  const UserUpdatedPassword({
    required this.email,
    required this.password,
  });
}
