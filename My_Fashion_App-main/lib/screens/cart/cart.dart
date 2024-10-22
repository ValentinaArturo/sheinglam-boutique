import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/common/dialog/custom_state_dialog.dart';
import 'package:my_fashion_app/common/loader/loader.dart';
import 'package:my_fashion_app/resources/constants.dart';
import 'package:my_fashion_app/screens/cart/bloc/cart_bloc.dart';
import 'package:my_fashion_app/screens/cart/model/cart_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(),
      child: const CartScreen(),
    );
  }
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartListModel> cartItems = [];
  final double shippingCost = 20.0;

  bool _isLoading = false;

  @override
  void initState() {
    _getCartList();
    super.initState();
  }

  void _getCartList() {
    context.read<CartBloc>().add(
          CartListShown(),
        );
  }

  @override
  Widget build(BuildContext context) {
    double total = cartItems.fold(
            0.0, (sum, item) => sum + item.producto!.precio! * item.cantidad!) +
        shippingCost;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
        centerTitle: true,
      ),
      body: BlocListener<CartBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case CartInProgress:
              setState(() => _isLoading = true);
              break;
            case CartListSuccess:
              final loadedState = state as CartListSuccess;
              setState(() {
                _isLoading = false;
                cartItems = loadedState.carrito;
              });
              break;
            case CartError:
              final stateError = state as CartError;
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Carrito',
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
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            final item = cartItems[index];
            if (_isLoading) {
              return const Loader();
            }
            return Dismissible(
              key: Key(item.producto!.nombre!),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  cartItems.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text('${item.producto!.nombre} eliminado del carrito'),
                  ),
                );
              },
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                color: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 4,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  leading: Image.asset(
                    '${imagePath}product${index + 1}.png',
                    width: 50,
                    height: 50,
                  ),
                  title: Text(
                    item.producto!.nombre!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Cantidad: ${item.cantidad}'),
                  trailing: Text(
                    '\$${(item.producto!.precio! * item.cantidad!).toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/payment');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.payment),
                  SizedBox(width: 8),
                  Text('Pagar', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
