import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/common/dialog/custom_state_dialog.dart';
import 'package:my_fashion_app/common/loader/loader.dart';
import 'package:my_fashion_app/repository/user_repository.dart';
import 'package:my_fashion_app/screens/cart/bloc/cart_bloc.dart';
import 'package:my_fashion_app/screens/cart/model/cart_model.dart';
import 'package:my_fashion_app/screens/payment/payment.dart';
import 'package:my_fashion_app/screens/productDetail/model/imagen_producto_model.dart';

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
  List<ImagenListModel> imagenes = [];

  final UserRepository _userRepository = UserRepository();

  late int _userId;
  bool _isLoading = false;

  @override
  void initState() {
    _getLocalUserId();
    super.initState();
  }

  void _getLocalUserId() async {
    _userId = int.parse(await _userRepository.getUserId()) - 1;
    _getCartList();
  }

  void _getCartList() {
    context.read<CartBloc>()
      ..add(
        CartListShown(),
      )
      ..add(
        ImagenShown(),
      );
  }

  Uint8List convertirBase64ABytes(String base64String) {
    return base64Decode(base64String);
  }

  @override
  Widget build(BuildContext context) {
    double total = cartItems.fold(
        0.0, (sum, item) => sum + item.producto!.precio! * item.cantidad!);

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
                cartItems = loadedState.carrito
                    .where(
                      (element) => element.carrito!.idCarrito == _userId,
                    )
                    .toList();
              });
              break;
            case ImagenSuccess:
              final loadedState = state as ImagenSuccess;
              setState(() {
                imagenes = loadedState.imagen;
                _isLoading = false;
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
                  leading: Image.memory(
                    convertirBase64ABytes(
                      imagenes
                          .firstWhere(
                            (element) =>
                                element.producto.idProducto ==
                                item.producto!.idProducto,
                          )
                          .imagenProducto,
                    ),
                    fit: BoxFit.cover,
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
                Navigator.pushNamed(
                  context,
                  '/payment',
                  arguments: PaymentArguments(
                    cartItems,
                    imagenes,
                  ),
                );
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
