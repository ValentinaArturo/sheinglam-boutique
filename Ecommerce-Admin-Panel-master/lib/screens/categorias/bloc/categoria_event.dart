part of 'categoria_bloc.dart';

abstract class CategoriaEvent extends Equatable {
  const CategoriaEvent();

  @override
  List<Object> get props => [];
}

final class CategoriaShown extends CategoriaEvent {}

final class CategoriaSaved extends CategoriaEvent {
  final String nombre;

  const CategoriaSaved({
    required this.nombre,
  });
}

final class CategoriaEdited extends CategoriaEvent {
  final String nombre;
  final int id;

  const CategoriaEdited({
    required this.nombre,
    required this.id,
  });
}

final class CategoriaDeleted extends CategoriaEvent {
  final int id;

  const CategoriaDeleted({
    required this.id,
  });
}
