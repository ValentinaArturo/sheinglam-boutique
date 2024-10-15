part of 'usuario_bloc.dart';

abstract class UsuarioEvent extends Equatable {
  const UsuarioEvent();

  @override
  List<Object> get props => [];
}

final class UsuarioShown extends UsuarioEvent {}

final class UsuarioSaved extends UsuarioEvent {
  final String nombre;
  final String apellido;
  final String correoElectronico;
  final String password;
  final int rol;

  const UsuarioSaved({
    required this.nombre,
    required this.apellido,
    required this.correoElectronico,
    required this.password,
    required this.rol,
  });
}

final class UsuarioEdited extends UsuarioEvent {
  final String nombre;
  final String apellido;
  final String correoElectronico;
  final String password;
  final int rol;
  final int id;

  const UsuarioEdited({
    required this.nombre,
    required this.apellido,
    required this.correoElectronico,
    required this.password,
    required this.rol,
    required this.id,
  });
}

final class UsuarioDeleted extends UsuarioEvent {
  final int id;

  const UsuarioDeleted({
    required this.id,
  });
}
