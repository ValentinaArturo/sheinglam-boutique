import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_admin_panel/common/bloc/base_state.dart';
import 'package:ecommerce_admin_panel/screens/shipment/model/shipment_list_model.dart';
import 'package:equatable/equatable.dart';

import '../model/detalle_factura_list_model.dart';
import '../model/factura_list_model.dart';

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
