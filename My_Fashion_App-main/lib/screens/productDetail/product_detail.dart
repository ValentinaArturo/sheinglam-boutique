import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/common/dialog/custom_state_dialog.dart';
import 'package:my_fashion_app/common/loader/loader.dart';
import 'package:my_fashion_app/repository/user_repository.dart';
import 'package:my_fashion_app/screens/productDetail/bloc/producto_detalle_bloc.dart';
import 'package:my_fashion_app/screens/productos/model/producto_list_model.dart';

class ScreenArguments {
  final ProductoListModel detail;
  final String imagen;

  ScreenArguments(
    this.detail,
    this.imagen,
  );
}

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        (ModalRoute.of(context)!.settings.arguments) as ScreenArguments;
    return BlocProvider(
      create: (context) => ProductoDetalleBloc(),
      child: ProductDetailScreen(
        args: args,
      ),
    );
  }
}

class ProductDetailScreen extends StatefulWidget {
  final ScreenArguments args;

  const ProductDetailScreen({
    super.key,
    required this.args,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final UserRepository _userRepository = UserRepository();

  late int _userId;
  late int _carritoId;
  late String image;

  bool _isLoading = false;
  bool _existeCarrito = false;

  @override
  void initState() {
    image = '';
    _getLocalUserId();
    super.initState();
  }

  void _getLocalUserId() async {
    _userId = int.parse(await _userRepository.getUserId()) - 1;
    _getProductoImagen();
    _getCart();
  }

  void _getProductoImagen() {
    context.read<ProductoDetalleBloc>().add(
          ImagenShown(
            idProducto: widget.args.detail.idProducto!,
          ),
        );
  }

  void _getCart() {
    context.read<ProductoDetalleBloc>().add(
          CarritoShown(
            idCliente: _userId,
          ),
        );
  }

  void _createCart() {
    context.read<ProductoDetalleBloc>().add(
          CarritoCreated(
            idCliente: _userId,
          ),
        );
  }

  void _addToCart() {
    context.read<ProductoDetalleBloc>().add(
          CarritoAdded(
            idCarrito: _carritoId,
            idProducto: widget.args.detail.idProducto!,
            cantidad: 1,
          ),
        );
  }

  void _updateCart() {
    context.read<ProductoDetalleBloc>().add(
          CarritoUpdated(
            id: _userId,
            idCarrito: _carritoId,
            idProducto: widget.args.detail.idProducto!,
            cantidad: 1,
          ),
        );
  }

  Uint8List convertirBase64ABytes(String base64String) {
    return base64Decode(base64String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Producto'),
        centerTitle: true,
      ),
      body: BlocListener<ProductoDetalleBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case ProductoDetalleInProgress:
              setState(() => _isLoading = true);
              break;
            case ProductoDetalleSuccess:
              final loadedState = state as ProductoDetalleSuccess;
              setState(() {
                _isLoading = false;
                image = loadedState.imagen.imagenProducto;
              });
              break;
            case CarritoObtainedSuccess:
              final loadedState = state as CarritoObtainedSuccess;
              setState(() {
                _isLoading = false;
                _existeCarrito = true;
                _carritoId = loadedState.carrito.idCarrito!;
              });
              break;
            case CarritoCreatedSuccess:
              _addToCart();
              break;
            case CarritoAddedSuccess:
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Producto Detalle',
                description: 'Producto agregado al carrito',
              );
              break;
            case CarritoUpdatedSuccess:
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Producto Detalle',
                description: 'Producto agregado al carrito',
              );
              break;
            case ProductoDetalleError:
              final stateError = state as ProductoDetalleError;
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Producto Detalle',
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
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.memory(
                        convertirBase64ABytes(widget.args.imagen),
                        fit: BoxFit.cover,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/ar_view',
                            arguments:
                                convertirBase64ABytes(widget.args.imagen));
                      },
                      icon: Icon(Icons.camera_alt_outlined),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.args.detail.nombre!,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.args.detail.descripcion!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.args.detail.precio!.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Talla: ${widget.args.detail.talla!.talla}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'Color: ${widget.args.detail.color!.color}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 28),
                        Icon(Icons.star, color: Colors.yellow, size: 28),
                        Icon(Icons.star, color: Colors.yellow, size: 28),
                        Icon(Icons.star, color: Colors.yellow, size: 28),
                        Icon(Icons.star_border, size: 28),
                        SizedBox(width: 8),
                        Text(
                          '4.0',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () =>
                          _existeCarrito ? _addToCart() : _createCart(),
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Agregar al Carrito',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        // Color dorado para el botón
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30.0), // Bordes redondeados
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
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
