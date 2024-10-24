import 'package:dio/dio.dart';
import 'package:ecommerce_admin_panel/factory/client_factory.dart';
import 'package:ecommerce_admin_panel/resources/api_constants.dart';
import 'package:ecommerce_admin_panel/screens/shipment/model/detalle_factura_list_model.dart';
import 'package:ecommerce_admin_panel/screens/shipment/model/factura_list_model.dart';
import 'package:ecommerce_admin_panel/screens/shipment/model/shipment_list_model.dart';

class ShipmentService {
  Dio client;

  ShipmentService() : client = ClientFactory.buildClient();

  ShipmentService.withClient(
    this.client,
  );

  Future<List<ShipmentListModel>> getShipment() async {
    final response = await client.get(
      shipmentPath,
    );
    return List<ShipmentListModel>.from(
      response.data.map(
        (shipment) => ShipmentListModel.fromJson(shipment),
      ),
    );
  }

  Future<List<FacturaListModel>> getFacturas() async {
    final response = await client.get(
      facturasPath,
    );
    return List<FacturaListModel>.from(
      response.data.map(
        (factura) => FacturaListModel.fromJson(factura),
      ),
    );
  }

  Future<List<DetalleFacturaListModel>> getDetalleFacturas() async {
    final response = await client.get(
      detalleFacturasPath,
    );
    return List<DetalleFacturaListModel>.from(
      response.data.map(
        (detalleFactura) => DetalleFacturaListModel.fromJson(detalleFactura),
      ),
    );
  }
}
