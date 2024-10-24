part of 'shipment_bloc.dart';

abstract class ShipmentEvent extends Equatable {
  const ShipmentEvent();

  @override
  List<Object> get props => [];
}

final class ShipmentsShown extends ShipmentEvent {}

final class FacturasShown extends ShipmentEvent {}

final class DetalleFacturasShown extends ShipmentEvent {}
