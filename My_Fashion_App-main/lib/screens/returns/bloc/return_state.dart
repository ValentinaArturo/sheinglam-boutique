part of 'return_bloc.dart';

abstract class ReturnState extends BaseState {}

class ReturnInitial extends ReturnState {}

class ReturnInProgress extends ReturnState {}

class ReturnSuccess extends ReturnState {
  final List<ReturnListModel> devoluciones;

  ReturnSuccess({
    required this.devoluciones,
  });
}

class ReturnError extends ReturnState {
  final String message;

  ReturnError({
    required this.message,
  });
}
