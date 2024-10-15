part of 'categoria_bloc.dart';

abstract class CategoriaState extends BaseState {}

final class CategoriaInitial extends CategoriaState {}

final class CategoriaInProgress extends CategoriaState {}

final class CategoriaSuccess extends CategoriaState {
  final List<CategoriaListModel> categorias;

  CategoriaSuccess({
    required this.categorias,
  });
}

final class CategoriaCreatedSuccess extends CategoriaState {}

final class CategoriaEditedSuccess extends CategoriaState {}

final class CategoriaDeletedSuccess extends CategoriaState {}

final class CategoriaError extends CategoriaState {
  final String message;

  CategoriaError({
    required this.message,
  });
}
