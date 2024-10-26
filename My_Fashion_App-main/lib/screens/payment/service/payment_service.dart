import 'package:dio/dio.dart';
import 'package:my_fashion_app/factory/client_factory.dart';
import 'package:my_fashion_app/resources/api_constants.dart';
import 'package:my_fashion_app/screens/payment/model/direccion_envio_model.dart';
import 'package:my_fashion_app/screens/payment/model/envio_model.dart';

class PaymentService {
  Dio client;

  PaymentService() : client = ClientFactory.buildClient();

  PaymentService.withClient(
    this.client,
  );

  Future<List<DireccionEnvioListModel>> getDireccionEnvio({
    required int idCliente,
  }) async {
    final response = await client.get(
      '$direccionEnvioPath/$idCliente',
    );
    return List<DireccionEnvioListModel>.from(
      response.data.map(
        (direccion) => DireccionEnvioListModel.fromJson(direccion),
      ),
    );
  }

  Future<EnvioModel> getEnvio({
    required int idDepartamento,
  }) async {
    final response = await client.get(
      '$envioPath/$idDepartamento',
    );
    return EnvioModel.fromJson(response.data);
  }

  Future<Response> createPedido({
    required int idCliente,
    required int idMetodoPago,
    required String fecha,
    required double total,
    required String nit,
  }) async {
    return await client.post(
      pedidoPath,
      data: {
        "cliente": {
          "idCliente": idCliente,
        },
        "fecha": fecha,
        "total": total,
        "metodoPago": {
          "idMetodoPago": idMetodoPago,
        },
        "nit": nit,
      },
    );
  }

  Future<Response> createDetallePedido({
    required int idPedido,
    required int idProducto,
    required int cantidad,
    required double precio,
    required double subTotal,
  }) async {
    return await client.post(
      detallePedidoPath,
      data: {
        "pedido": {
          "idPedido": idPedido,
        },
        "producto": {
          "idProducto": idProducto,
        },
        "cantidad": cantidad,
        "precioUnitario": precio,
        "subtotal": subTotal,
      },
    );
  }

  Future<Response> createEstadoPedido({
    required String estado,
  }) async {
    return await client.post(
      pedidoEstadoPath,
      data: {
        "nombre": "Enviado",
      },
    );
  }

  Future<Response> createEnvio({
    required int idPedido,
    required String metodoEnvio,
    required double costoEnvio,
    required String fechaEnvio,
  }) async {
    return await client.post(
      envioPath,
      data: {
        "pedido": {
          "idPedido": idPedido,
        },
        "metodoEnvio": metodoEnvio,
        "costoEnvio": costoEnvio,
        "fechaEnvio": fechaEnvio,
      },
    );
  }

  Future<Response> createFactura({
    required int idPedido,
    required double total,
    required String fecha,
  }) async {
    return await client.post(
      facturaPath,
      data: {
        "pedido": {
          "id": idPedido,
        },
        "total": total,
        "fecha": fecha,
      },
    );
  }

  Future<Response> createDetalleFactura({
    required int idFactura,
    required int idProducto,
    required int cantidad,
    required double precioUntario,
    required double subTotal,
  }) async {
    return await client.post(
      facturaDetallePath,
      data: {
        "factura": {
          "idFactura": idFactura,
        },
        "producto": {
          "idProducto": idProducto,
        },
        "cantidad": cantidad,
        "precioUnitario": precioUntario,
        "subtotal": subTotal,
      },
    );
  }
}
