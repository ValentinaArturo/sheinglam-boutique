part of 'promociones_bloc.dart';

abstract class PromocionesState extends BaseState {}

class PromocionesInitial extends PromocionesState {}

class PromocionesInProgress extends PromocionesState {}

class PromocionesListSuccess extends PromocionesState {
  final List<PromocionListModel> promociones;

  PromocionesListSuccess({
    required this.promociones,
  });
}

class PromocionesCreatedSuccess extends PromocionesState {}

class PromocionesEditedSuccess extends PromocionesState {}

class PromocionesDeletedSuccess extends PromocionesState {}

class PromocionesError extends PromocionesState {
  final String message;

  PromocionesError({
    required this.message,
  });
}
