import 'package:ecommerce_admin_panel/common/bloc/base_state.dart';
import 'package:ecommerce_admin_panel/common/dialog/custom_state_dialog.dart';
import 'package:ecommerce_admin_panel/common/loader/loader.dart';
import 'package:ecommerce_admin_panel/common/menu_drawer.dart';
import 'package:ecommerce_admin_panel/screens/categorias/model/categoria_list_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/bloc/productos_bloc.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/color_list_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/producto_list_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/producto_promocion_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/proveedor_list_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/talla_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductoBloc(),
      child: const ProductsScreen(),
    );
  }
}

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _descripcion = TextEditingController();
  final TextEditingController _precio = TextEditingController();
  final TextEditingController _stock = TextEditingController();

  List<ProductoListModel> productos = [];
  List<CategoriaListModel> categorias = [];
  List<ProveedorListModel> proveedores = [];
  List<ProductoPromocionListModel> productoPromociones = [];
  List<TallaListModel> tallas = [];
  List<ColorListModel> colores = [];
  List<ProductoListModel> filteredProductos = [];

  bool _isLoading = false;
  late int? idTalla;
  late int? idColor;
  late int? idProveedor;
  late int? _idProducto;

  @override
  void initState() {
    super.initState();
    idProveedor = null;
    idColor = null;
    idTalla = null;
    _getProductos();
    _getProveedores();
    _getTallas();
    _getColores();
    _getCategorias();
    _getCategorias();
    _getProductoPromocion();
  }

  void _getProductos() {
    context.read<ProductoBloc>().add(
          ProductoShown(),
        );
  }

  void _getCategorias() {
    context.read<ProductoBloc>().add(
          CategoriaShown(),
        );
  }

  void _getProductoPromocion() {
    context.read<ProductoBloc>().add(
          ProductoPromocionShown(),
        );
  }

  void _getProveedores() {
    context.read<ProductoBloc>().add(
          ProveedorShown(),
        );
  }

  void _getTallas() {
    context.read<ProductoBloc>().add(
          TallaShown(),
        );
  }

  void _getColores() {
    context.read<ProductoBloc>().add(
          ColorShown(),
        );
  }

  void _getImagenesById({required int productoId}) {
    context.read<ProductoBloc>().add(
          ImagenByIdShown(
            productoId: productoId,
          ),
        );
  }

  void _createProducto() {
    context.read<ProductoBloc>().add(
          ProductoSaved(
            nombre: _nombre.text,
            descripcion: _descripcion.text,
            precio: double.parse(_precio.text),
            idTalla: idTalla!,
            idColor: idColor!,
            stock: int.parse(_stock.text),
            idProveedor: idProveedor!,
          ),
        );
  }

  void _editProducto() {
    context.read<ProductoBloc>().add(
          ProductoEdited(
            nombre: _nombre.text,
            descripcion: _descripcion.text,
            precio: double.parse(_precio.text),
            idTalla: idTalla!,
            idColor: idColor!,
            stock: int.parse(_stock.text),
            idProveedor: idProveedor!,
            id: _idProducto!,
          ),
        );
  }

  void _createImagenByProduct({required int productoId}) {
    // context.read<ProductoBloc>().add(
    //       ImageCreated(
    //         idProducto: productoId,
    //         imagen: imagen,
    //       ),
    //     );
  }

  void _filterProductos(String query) {
    final results = productos.where((producto) {
      final tituloLower = producto.nombre.toLowerCase();
      final queryLower = query.toLowerCase();
      return tituloLower.contains(queryLower);
    }).toList();

    setState(() {
      filteredProductos = results;
    });
  }

  void _showEditModal([bool isEdit = false]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isEdit ? 'Editar Usuario' : 'Crear Usuario'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  controller: _nombre,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Descripcion'),
                  controller: _descripcion,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Precio'),
                  controller: _precio,
                ),
                DropdownButton(
                  value: idTalla,
                  onChanged: (value) {
                    setState(() => idTalla = value);
                  },
                  items: tallas
                      .map<DropdownMenuItem>((talla) => DropdownMenuItem(
                            value: talla.idTalla,
                            child: Text(talla.talla),
                          ))
                      .toList(),
                ),
                DropdownButton(
                  value: idColor,
                  onChanged: (value) {
                    setState(() => idColor = value);
                  },
                  items: colores
                      .map<DropdownMenuItem>((color) => DropdownMenuItem(
                            value: color.idColor,
                            child: Text(color.color),
                          ))
                      .toList(),
                ),
                DropdownButton(
                  value: idProveedor,
                  onChanged: (value) {
                    setState(() => idProveedor = value);
                  },
                  items: proveedores
                      .map<DropdownMenuItem>((proveedor) => DropdownMenuItem(
                            value: proveedor.idProveedor,
                            child: Text(proveedor.nombre),
                          ))
                      .toList(),
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Stock'),
                  controller: _stock,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                isEdit ? _editProducto() : _createProducto();
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      appBar: AppBar(
        title: const Text('Lista de Productos'),
        actions: [
          TextButton.icon(
            onPressed: () {
              _nombre.clear();
              _descripcion.clear();
              _precio.clear();
              _showEditModal();
            },
            icon: const Icon(Icons.add, color: Colors.black),
            label: const Text(
              'Agregar',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: BlocListener<ProductoBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (ProductoInProgress):
              setState(() => _isLoading = true);
              break;
            case const (ProductoSuccess):
              final loadedState = state as ProductoSuccess;
              setState(() {
                _isLoading = false;
                productos = loadedState.productos;
                filteredProductos = loadedState.productos;
              });
              break;
            case const (CategoriaSuccess):
              final loadedState = state as CategoriaSuccess;
              setState(() {
                _isLoading = false;
                categorias = loadedState.categorias;
              });
              break;
            case const (ProductoPromocionSuccess):
              final loadedState = state as ProductoPromocionSuccess;
              setState(() {
                _isLoading = false;
                productoPromociones = loadedState.promociones;
              });
              break;
            case const (ProductoCreatedSuccess):
              _getProductos();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Productos',
                description: "Producto creado correctamente",
              );
              break;
            case const (CategoriaCreatedSuccess):
              _getProductos();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Categoria',
                description: "Categoria creada correctamente",
              );
              break;
            case const (ProductoPromocionCreatedSuccess):
              _getProductos();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Producto Promocion',
                description: "Producto Promocion creada correctamente",
              );
              break;
            case const (ProductoEditedSuccess):
              _getProductos();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Productos',
                description: "Producto editado correctamente",
              );
              break;
            case const (ProductoDeletedSuccess):
              _getProductos();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Productos',
                description: "Producto borrado correctamente",
              );
              break;
            case const (ProveedorSuccess):
              final loadedState = state as ProveedorSuccess;
              setState(() {
                _isLoading = false;
                idProveedor = loadedState.proveedores.first.idProveedor;
                proveedores = loadedState.proveedores;
              });
              break;
            case const (TallaSuccess):
              final loadedState = state as TallaSuccess;
              setState(() {
                _isLoading = false;
                idTalla = loadedState.tallas.first.idTalla;
                tallas = loadedState.tallas;
              });
              break;
            case const (ColorSuccess):
              final loadedState = state as ColorSuccess;
              setState(() {
                _isLoading = false;
                idColor = loadedState.colores.first.idColor;
                colores = loadedState.colores;
              });
              break;
            case const (ProductoError):
              final stateError = state as ProductoError;
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Productos',
                description: stateError.message,
                isError: true,
              );
              break;
            case const (ServerClientError):
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
            Positioned.fill(
              child: Image.asset(
                'assets/images/fondo_agua.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Buscar productos...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                      onChanged: _filterProductos,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Table(
                        border: TableBorder.all(color: Colors.grey),
                        columnWidths: const {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(4),
                          2: FlexColumnWidth(2),
                          3: FlexColumnWidth(1),
                          4: FixedColumnWidth(100),
                          5: FixedColumnWidth(100),
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                            ),
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Título',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Descripción',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Categoría',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Talla',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Editar',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Eliminar',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          ...filteredProductos.map((producto) {
                            return TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(producto.nombre),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(producto.descripcion),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(producto.proveedor.nombre),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(producto.talla.talla),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: const Icon(Icons.edit,
                                        color: Colors.black),
                                    onPressed: () {
                                      setState(() {
                                        _nombre.text = producto.nombre;
                                        _descripcion.text =
                                            producto.descripcion;
                                        _precio.text =
                                            producto.precio.toString();
                                        idTalla = producto.talla.idTalla;
                                        idColor = producto.color.idColor;
                                        _stock.text = producto.stock.toString();
                                        idProveedor =
                                            producto.proveedor.idProveedor;
                                      });
                                      _showEditModal(true);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.black),
                                    onPressed: () {
                                      // Lógica para eliminar el producto
                                    },
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
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
