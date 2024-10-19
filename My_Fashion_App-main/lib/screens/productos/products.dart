import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/common/dialog/custom_state_dialog.dart';
import 'package:my_fashion_app/common/loader/loader.dart';
import 'package:my_fashion_app/resources/constants.dart';
import 'package:my_fashion_app/screens/productos/bloc/productos_bloc.dart';
import 'package:my_fashion_app/screens/productos/model/producto_list_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductoBloc(),
      child: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductoListModel> productos = [];

  bool _isLoading = false;

  @override
  void initState() {
    _getProductos();
    super.initState();
  }

  void _getProductos() {
    context.read<ProductoBloc>().add(
          ProductoShown(),
        );
  }

  void _filterProductos(String query) {
    final results = productos.where((producto) {
      final tituloLower = producto.producto.nombre.toLowerCase();
      final queryLower = query.toLowerCase();

      return tituloLower.contains(queryLower);
    }).toList();

    setState(() {
      productos = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.white,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.shopping_cart_outlined),
            label: 'Carrito',
            onTap: () => Navigator.pushNamed(context, '/cart'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.list_alt),
            label: 'Pedidos',
            onTap: () => Navigator.pushNamed(context, '/orders'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.person),
            label: 'Perfil',
            onTap: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 100,
        centerTitle: true,
        title: Image.asset(
          'assets/images/SG.jpg',
          height: 100,
        ),
      ),
      body: BlocListener<ProductoBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case ProductoInProgress:
              setState(() => _isLoading = true);
              break;
            case ProductoSuccess:
              final loadedState = state as ProductoSuccess;
              setState(() {
                _isLoading = false;
                productos = loadedState.productos;
              });
              break;
            case ProductoError:
              final stateError = state as ProductoError;
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Productos',
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
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar productos...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    onChanged: _filterProductos,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(8.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: productos.length,
                      // Usar el número de productos en la lista
                      itemBuilder: (context, index) {
                        final producto = productos[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context,
                                '/product_detail',
                              arguments: producto,
                            );
                          },
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(15.0),
                                    ),
                                    child: Image.asset(
                                      '${imagePath}product${index+1}.png',
                                      fit: BoxFit.fitHeight,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        producto.producto.nombre,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '\$${producto.producto.precio.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
            )
          ],
        ),
      ),
    );
  }
}
