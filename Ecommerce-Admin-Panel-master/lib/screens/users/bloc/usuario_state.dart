part of 'usuario_bloc.dart';

abstract class UsuarioState extends BaseState {}

final class UsuarioInitial extends UsuarioState {}

final class UsuarioInProgress extends UsuarioState {}

final class UsuarioSuccess extends UsuarioState {
  final List<ClientListModel> usuarios;

  UsuarioSuccess({
    required this.usuarios,
  });
}

final class CiudadSuccess extends UsuarioState {
  final List<CiudadListModel> ciudades;

  CiudadSuccess({
    required this.ciudades,
  });
}

final class UsuarioCreatedSuccess extends UsuarioState {}

final class UsuarioEditedSuccess extends UsuarioState {}

final class UsuarioDeletedSuccess extends UsuarioState {}

final class DireccionEnvioCreatedSuccess extends UsuarioState {}

final class DireccionEnvioEditedSuccess extends UsuarioState {}

final class UsuarioError extends UsuarioState {
  final String message;

  UsuarioError({
    required this.message,
  });
}
