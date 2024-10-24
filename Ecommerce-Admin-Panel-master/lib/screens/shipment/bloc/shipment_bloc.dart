import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shipment_event.dart';
part 'shipment_state.dart';

class ShipmentBloc extends Bloc<ShipmentEvent, ShipmentState> {
  ShipmentBloc() : super(ShipmentInitial());

  @override
  Stream<ShipmentState> mapEventToState(
    ShipmentEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
