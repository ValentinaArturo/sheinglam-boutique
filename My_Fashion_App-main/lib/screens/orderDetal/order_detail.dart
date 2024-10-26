import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/common/dialog/custom_state_dialog.dart';
import 'package:my_fashion_app/common/loader/loader.dart';
import 'package:my_fashion_app/resources/constants.dart';
import 'package:my_fashion_app/screens/orderDetal/bloc/orderdetail_bloc.dart';
import 'package:my_fashion_app/screens/orderDetal/model/order_model.dart';

import 'package:my_fashion_app/screens/return_form.dart';
import 'package:my_fashion_app/screens/review_modal.dart';

class OrderDetailPage extends StatelessWidget {
  final int idOrden;

  const OrderDetailPage({
    super.key,
    required this.idOrden,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderdetailBloc(),
      child: OrderDetailScreen(
        idOrden: idOrden,
      ),
    );
  }
}

class OrderDetailScreen extends StatefulWidget {
  final int idOrden;

  const OrderDetailScreen({
    super.key,
    required this.idOrden,
  });

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  OrderDetailListModel orderDetail = OrderDetailListModel();

  bool _isLoading = false;

  @override
  void initState() {
    _getOrderDetail();
    super.initState();
  }

  void _getOrderDetail() {
    context.read<OrderdetailBloc>().add(
          OrderDetailShown(
            id: widget.idOrden,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Pedido'),
        centerTitle: true,
      ),
      body: BlocListener<OrderdetailBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case OrderInProgress:
              setState(() => _isLoading = true);
              break;
            case OrderDetailSuccess:
              final loadedState = state as OrderDetailSuccess;
              setState(() {
                _isLoading = false;
                orderDetail = loadedState.detalle;
              });
              break;
            case OrderError:
              final stateError = state as OrderError;
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Detalle de orden',
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
                    'Productos del Pedido',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Card(
                      elevation: 10,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Cliente',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text('Nombre: ${orderDetail.pedido?.cliente?.usuario?.nombre}'),
                            Text('Apellido: ${orderDetail.pedido?.cliente?.usuario?.apellido}'),
                            Text('Correo: ${orderDetail.pedido?.cliente?.usuario?.correoElectronico}'),
                            Text('Direccion: ${orderDetail.pedido?.cliente?.direccion}'),
                            const SizedBox(height: 20,),
                            Text(
                              'Producto',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text('Nombre: ${orderDetail.producto?.nombre}'),
                            Text('Descripcion: ${orderDetail.producto?.descripcion}'),
                            Text('Precio: \$ ${orderDetail.producto?.precio}'),
                            Text('Talla: ${orderDetail.producto?.talla?.talla}'),
                            Text('Color: ${orderDetail.producto?.color?.color}'),
                            const SizedBox(height: 20,),
                            Text(
                              'Pago',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text('Medodo de pago: ${orderDetail.pedido?.metodoPago}'),
                            Text('Nit: ${orderDetail.pedido?.nit}'),
                            Text('Subtotal: ${orderDetail.subtotal}'),
                            Text('Total: ${orderDetail.pedido?.total}'),
                          ],
                        ),
                      )
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
