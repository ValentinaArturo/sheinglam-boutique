part of 'promociones_bloc.dart';

abstract class PromocionesEvent extends Equatable {
  const PromocionesEvent();

  @override
  List<Object> get props => [];
}

final class PromocionesShown extends PromocionesEvent {}

final class PromocionesCreated extends PromocionesEvent {
  final String nombre;
  final String descripcion;
  final double descuento;

  const PromocionesCreated({
    required this.nombre,
    required this.descripcion,
    required this.descuento,
  });
}

final class PromocionesEdited extends PromocionesEvent {
  final int id;
  final String nombre;
  final String descripcion;
  final double descuento;

  const PromocionesEdited({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.descuento,
  });
}

final class PromocionesDeleted extends PromocionesEvent {
  final int id;

  const PromocionesDeleted({
    required this.id,
  });
}
