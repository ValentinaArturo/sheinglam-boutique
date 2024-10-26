part of 'recover_bloc.dart';

abstract class RecoverState extends BaseState {}

class RecoverInitial extends RecoverState {}

class RecoverInProgress extends RecoverState {}

class RecoverPinSendSuccess extends RecoverState {}

class RecoverPinValidatedSuccess extends RecoverState {}

class RecoverUserUpdatedSuccess extends RecoverState {}

class RecoverError extends RecoverState {
  final String message;

  RecoverError({
    required this.message,
  });
}
