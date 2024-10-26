part of 'register_bloc.dart';

abstract class RegisterState extends BaseState {}

class RegisterInitial extends RegisterState {}

class RegisterInProgress extends RegisterState {}

class RegisterUserSuccess extends RegisterState {}

class RegisterUserUpdatedSuccess extends RegisterState {}

class RegisterClientListSuccess extends RegisterState {
  final List<ClienteListModel> clientes;

  RegisterClientListSuccess({
    required this.clientes,
  });
}

class RegisterAddressListSuccess extends RegisterState {
  final List<AddressListModel> direcciones;

  RegisterAddressListSuccess({
    required this.direcciones,
  });
}

class RegisterError extends RegisterState {
  final String message;

  RegisterError({
    required this.message,
  });
}
