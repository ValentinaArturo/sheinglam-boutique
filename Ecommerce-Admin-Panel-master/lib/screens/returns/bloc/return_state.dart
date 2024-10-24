part of 'return_bloc.dart';

abstract class ReturnState extends BaseState {}

class ReturnInitial extends ReturnState {}

class ReturnInProgress extends ReturnState {}

class ReturnListSuccess extends ReturnState {
  final List<ReturnListModel> proveedores;

  ReturnListSuccess({
    required this.proveedores,
  });
}

class ReturnCreatedSuccess extends ReturnState {}

class ReturnEditedSuccess extends ReturnState {}

class ReturnDeletedSuccess extends ReturnState {}

class ReturnError extends ReturnState {
  final String message;

  ReturnError({
    required this.message,
  });
}
