part of 'proveedor_bloc.dart';

abstract class ProveedorState extends BaseState {}

class ProveedorInitial extends ProveedorState {}

class ProveedorInProgress extends ProveedorState {}

class ProveedorListSuccess extends ProveedorState {
  final List<ProveedorListModel> proveedores;

  ProveedorListSuccess({
    required this.proveedores,
  });
}

class ProveedorCreatedSuccess extends ProveedorState {}

class ProveedorEditedSuccess extends ProveedorState {}

class ProveedorDeletedSuccess extends ProveedorState {}

class ProveedorError extends ProveedorState {
  final String message;

  ProveedorError({
    required this.message,
  });
}
