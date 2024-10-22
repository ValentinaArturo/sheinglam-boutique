import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/common/dialog/custom_state_dialog.dart';
import 'package:my_fashion_app/common/loader/loader.dart';
import 'package:my_fashion_app/screens/order_detail.dart';
import 'package:my_fashion_app/screens/orders/bloc/order_bloc.dart';
import 'package:my_fashion_app/screens/orders/model/order_list_model.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc(),
      child: const OrdersScreen(),
    );
  }
}

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<OrderListModel> productosPedido = [];
  bool _isLoading = false;

  @override
  void initState() {
    _getOrderList();
    super.initState();
  }

  void _getOrderList() {
    context.read<OrderBloc>().add(
          OrderShown(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Pedidos'),
        centerTitle: true,
      ),
      body: BlocListener<OrderBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case OrderInProgress:
              setState(() => _isLoading = true);
              break;
            case OrderSuccess:
              final loadedState = state as OrderSuccess;
              setState(() {
                _isLoading = false;
                productosPedido = loadedState.ordenes;
              });
              break;
            case OrderError:
              final stateError = state as OrderError;
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Ordenes',
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
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: 5, // Número de pedidos
          itemBuilder: (context, index) {
            // Simulación del estado del pedido
            String estado = index % 2 == 0 ? 'Completado' : 'En Proceso';
            if (_isLoading) {
              return const Loader();
            }
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 4,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(
                  'Pedido #$index',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      'Total: \$200',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Estado: $estado',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: estado == 'Completado'
                            ? const Color(0xFFAB9144)
                            : Colors.orangeAccent,
                      ),
                    ),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailScreen(
                        productos: productosPedido,
                        total: 200, // Total simulado
                        estado: estado,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
