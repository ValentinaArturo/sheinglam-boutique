import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/common/dialog/custom_state_dialog.dart';
import 'package:my_fashion_app/common/loader/loader.dart';
import 'package:my_fashion_app/resources/constants.dart';
import 'package:my_fashion_app/screens/productDetail/bloc/producto_detalle_bloc.dart';
import 'package:my_fashion_app/screens/productos/model/producto_list_model.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        (ModalRoute.of(context)!.settings.arguments) as ProductoListModel;
    return BlocProvider(
      create: (context) => ProductoDetalleBloc(),
      child: ProductDetailScreen(detail: args),
    );
  }
}

class ProductDetailScreen extends StatefulWidget {
  final ProductoListModel detail;
  const ProductDetailScreen({
    super.key,
    required this.detail,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String image = 'product1.png';
  bool _isLoading = false;

  @override
  void initState() {
    _getProductoImagen();
    super.initState();
  }

  void _getProductoImagen() {
    context.read<ProductoDetalleBloc>().add(
          ImagenShown(
            idProducto: widget.detail.producto.idProducto,
          ),
        );
  }

  void _addToCart() {
    context.read<ProductoDetalleBloc>().add(CarritoAdded(
          idCarrito: 1,
          idProducto: widget.detail.producto.idProducto,
          cantidad: 1,
        ));
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
            case CarritoCreatedSuccess:
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
                      child: Image.asset(
                        '$imagePath$image',
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.detail.producto.nombre,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.detail.producto.descripcion,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Talla: ${widget.detail.producto.talla.talla}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'Color: ${widget.detail.producto.color.color}',
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
                      onPressed: () => _addToCart(),
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
                            vertical: 15.0, horizontal: 20.0),
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
