part of 'proveedor_bloc.dart';

abstract class ProveedorEvent extends Equatable {
  const ProveedorEvent();

  @override
  List<Object> get props => [];
}

final class ProveedorShown extends ProveedorEvent {}

final class ProveedorCreated extends ProveedorEvent {
  final String nombre;
  final String direccion;
  final String telefono;
  final String email;
  final String nit;

  const ProveedorCreated({
    required this.nombre,
    required this.direccion,
    required this.telefono,
    required this.email,
    required this.nit,
  });
}

final class ProveedorEdited extends ProveedorEvent {
  final int id;
  final String nombre;
  final String direccion;
  final String telefono;
  final String email;
  final String nit;

  const ProveedorEdited({
    required this.id,
    required this.nombre,
    required this.direccion,
    required this.telefono,
    required this.email,
    required this.nit,
  });
}

final class ProveedorDeleted extends ProveedorEvent {
  final int id;

  const ProveedorDeleted({
    required this.id,
  });
}
