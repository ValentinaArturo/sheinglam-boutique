import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/common/dialog/custom_state_dialog.dart';
import 'package:my_fashion_app/common/loader/loader.dart';
import 'package:my_fashion_app/repository/user_repository.dart';
import 'package:my_fashion_app/screens/cart/model/cart_model.dart';
import 'package:my_fashion_app/screens/payment/bloc/payment_bloc.dart';
import 'package:my_fashion_app/screens/payment/model/direccion_envio_model.dart';
import 'package:my_fashion_app/screens/payment/model/envio_model.dart';
import 'package:my_fashion_app/screens/productDetail/model/imagen_producto_model.dart';

class PaymentArguments {
  final List<CartListModel> cartList;
  final List<ImagenListModel> imagenList;

  PaymentArguments(
    this.cartList,
    this.imagenList,
  );
}

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        (ModalRoute.of(context)!.settings.arguments) as PaymentArguments;
    return BlocProvider(
      create: (context) => PaymentBloc(),
      child: PaymentScreen(
        args: args,
      ),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  final PaymentArguments args;
  const PaymentScreen({
    super.key,
    required this.args,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<DireccionEnvioListModel> direccionEnvio = [];
  EnvioModel envioModel = EnvioModel();
  double tarifaEnvio = 5.99;

  final UserRepository _userRepository = UserRepository();

  late int? _userId;
  bool _isLoading = false;

  @override
  void initState() {
    _userId = null;
    _getLocalUserId();
    super.initState();
  }

  void _getLocalUserId() async {
    _userId = int.parse(await _userRepository.getUserId()) - 1;
    _getDireccionEnvio();
  }

  void _getDireccionEnvio() {
    context.read<PaymentBloc>().add(
          DireccionEnvioShown(
            idCliente: _userId!,
          ),
        );
  }

  void _getEnvio() {
    context.read<PaymentBloc>().add(
          EnvioShown(
            idDepartamento: direccionEnvio[0].ciudad!.idCiudad!,
          ),
        );
  }

  void _createPedido() {
    context.read<PaymentBloc>().add(
          PedidoCreated(
            idCliente: _userId!,
            idMetodoPago: envioModel.pedido!.metodoPago!.idMetodoPago!,
            fecha: '${envioModel.fechaEnvio}',
            total: envioModel.pedido!.total!,
            nit: envioModel.pedido!.nit!,
          ),
        );
  }

  void _createDetallePedido() {
    context.read<PaymentBloc>().add(
          DetallePedidoCreated(
            idPedido: envioModel.pedido!.idPedido!,
            idProducto: widget.args.cartList[0].producto!.idProducto!,
            cantidad: widget.args.cartList[0].cantidad!,
            precio: widget.args.cartList[0].producto!.precio!,
            subTotal: widget.args.cartList[0].producto!.precio!,
          ),
        );
  }

  void _createEstadoPedido() {
    context.read<PaymentBloc>().add(
          const EstadoPedidoCreated(
            estado: 'Enviado',
          ),
        );
  }

  void _createEnvio() {
    context.read<PaymentBloc>().add(
          EnvioCreated(
            idPedido: envioModel.pedido!.idPedido!,
            metodoEnvio: envioModel.metodoEnvio!,
            costoEnvio: envioModel.costoEnvio!,
            fechaEnvio: '${envioModel.fechaEnvio}',
          ),
        );
  }

  void _createFactura() {
    context.read<PaymentBloc>().add(
          FacturaCreated(
            idPedido: envioModel.pedido!.idPedido!,
            total: envioModel.pedido!.total!,
            fecha: '${DateTime.now()}',
          ),
        );
  }

  void _createFacturaDetalle() {
    context.read<PaymentBloc>().add(
          FacturaDetalleCreated(
            idFactura: 1,
            idProducto: widget.args.cartList[0].producto!.idProducto!,
            cantidad: widget.args.cartList[0].cantidad!,
            precioUntario: widget.args.cartList[0].producto!.precio!,
            subTotal: widget.args.cartList[0].producto!.precio!,
          ),
        );
  }

  Uint8List convertirBase64ABytes(String base64String) {
    return base64Decode(base64String);
  }

  @override
  Widget build(BuildContext context) {
    double total = widget.args.cartList.fold(
          0.0,
          (sum, item) => sum + item.producto!.precio! * item.cantidad!,
        ) +
        tarifaEnvio;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen de Pago'),
      ),
      body: BlocListener<PaymentBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case PaymentInProgress:
              setState(() => _isLoading = true);
              break;
            case DireccionEnvioObtainedSuccess:
              final loadedData = state as DireccionEnvioObtainedSuccess;
              setState(() {
                _isLoading = false;
                direccionEnvio = loadedData.direccionEnvio;
              });
              _getEnvio();
              break;
            case EnvioObtainedSuccess:
              final loadedData = state as EnvioObtainedSuccess;
              setState(() {
                _isLoading = false;
                envioModel = loadedData.envioModel;
                tarifaEnvio = loadedData.envioModel.costoEnvio!;
              });
              break;
            case PedidoCreatedSuccess:
              setState(() => _isLoading = false);
              _createDetallePedido();
              break;
            case DetallePedidoCreatedSuccess:
              setState(() => _isLoading = false);
              _createEstadoPedido();
              break;
            case EstadoPedidoCreatedSuccess:
              setState(() => _isLoading = false);
              _createEnvio();
              break;
            case EnvioCreatedSuccess:
              setState(() => _isLoading = false);
              _createFactura();
              break;
            case FacturaCreatedSuccess:
              setState(() => _isLoading = false);
              _createFacturaDetalle();
              break;
            case DetalleFacturaCreatedSuccess:
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Pago',
                description: "Pedido creado satisfactoriamente",
                isError: true,
              );
              break;
            case PaymentError:
              final stateError = state as PaymentError;
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Pago',
                description: stateError.message,
                isError: true,
              );
              break;
            case ServerClientError:
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Error',
                description: 'En este momento no podemos atender tu solicitud.',
                isError: true,
              );
              break;
          }
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Resumen de Productos',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.args.cartList.length,
                      itemBuilder: (context, index) {
                        final producto = widget.args.cartList[index];
                        return ListTile(
                          leading: Image.memory(
                            convertirBase64ABytes(
                              widget.args.imagenList
                                  .firstWhere(
                                    (element) =>
                                        element.producto.idProducto ==
                                        producto.producto!.idProducto,
                                  )
                                  .imagenProducto,
                            ),
                            fit: BoxFit.cover,
                          ),
                          title: Text(producto.producto!.nombre!),
                          trailing: Text(
                            '\$${producto.producto!.precio!.toStringAsFixed(2)}',
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tarifa de Envío:',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '\$${tarifaEnvio.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${total.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _createPedido();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 32.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text(
                        'Realizar Pago',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Builder(
              builder: (context) {
                if (_isLoading) {
                  return const Loader();
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
