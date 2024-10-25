import 'dart:convert';
import 'dart:typed_data';

import 'package:ecommerce_admin_panel/common/bloc/base_state.dart';
import 'package:ecommerce_admin_panel/common/dialog/custom_state_dialog.dart';
import 'package:ecommerce_admin_panel/common/loader/loader.dart';
import 'package:ecommerce_admin_panel/common/menu_drawer.dart';
import 'package:ecommerce_admin_panel/screens/categorias/model/categoria_list_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/bloc/productos_bloc.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/categoria_producto_list_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/color_list_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/imagen_producto_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/producto_list_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/producto_promocion_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/proveedor_list_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/talla_list_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
  List<CategoriaPorductoListModel> productosCategorias = [];
  List<CategoriaListModel> categorias = [];
  List<ProveedorListModel> proveedores = [];
  List<ProductoPromocionListModel> productoPromociones = [];
  List<TallaListModel> tallas = [];
  List<ColorListModel> colores = [];
  List<ProductoListModel> filteredProductos = [];
  List<ImagenProductoModel> imagenesProductos = [];
  Uint8List? imagenBytes;
  String? imagenBase64;

  bool _isLoading = false;
  late int? idTalla;
  late int? idColor;
  late int? idProveedor;
  late int? _idProducto;
  late int? idCategoria;

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
    _getProductoPromocion();
    _getProductoCategoria();
    _getImagenproducto();
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

  void _getProductoCategoria() {
    context.read<ProductoBloc>().add(
          ProductoCategoriaShown(),
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

  void _getImagenproducto() {
    context.read<ProductoBloc>().add(
          ImagenesProductoShown(),
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

  void _createImagenByProduct({
    required int productoId,
  }) {
    context.read<ProductoBloc>().add(
          ImageCreated(
            idProducto: productoId,
            imagen: imagenBase64!,
          ),
        );
  }

  void _deleteImagenByProduct({
    required int imagenProducto,
  }) {
    context.read<ProductoBloc>().add(
          ImageDeleted(
            imagenproductoId: imagenProducto.toString(),
          ),
        );
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
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(isEdit ? 'Editar Producto' : 'Crear Producto'),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton(
                        value: idColor,
                        onChanged: (value) {
                          setState(() => idColor = value);
                        },
                        items: colores
                            .map<DropdownMenuItem>((color) => DropdownMenuItem(
                                  value: color.idColor,
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Color(int.parse(color.color)),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          _selectColor();
                        },
                      ),
                    ],
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
        });
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
              _getProductoCategoria();
              break;
            case const (ProductoPromocionCreatedSuccess):
              _getProductoPromocion();
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

            case const (ProductoCategoriaSuccess):
              final loadedState = state as ProductoCategoriaSuccess;
              setState(() {
                productosCategorias = loadedState.productoCategorias;
                _isLoading = false;
              });
              break;
            case const (ImagenProductoSuccess):
              final loadedState = state as ImagenProductoSuccess;
              setState(() {
                imagenesProductos = loadedState.imagenesProductos;
                _isLoading = false;
              });
              break;
            case const (ImagenDeletedSuccess):
              _getImagenproducto();
              break;
            case const (ImagenCreatedSuccess):
              _getImagenproducto();
              break;
            case const (ProductoCategoriaEditedSuccess):
              _getProductoCategoria();
              break;
            case const (ProductoPromocionDeletedSuccess):
              _getProductoPromocion();
              break;
            case const (ColorCreatedSuccess):
              _getColores();
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
                          3: FlexColumnWidth(2),
                          4: FlexColumnWidth(1),
                          5: FlexColumnWidth(2),
                          6: FixedColumnWidth(100),
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
                                  'Imagen',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Nombre',
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
                                  'Promoción',
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
                            ],
                          ),
                          ...filteredProductos.map((producto) {
                            return TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 100,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: obtenerImagenesProducto(
                                                    producto.idProducto,
                                                    imagenesProductos)
                                                .length,
                                            itemBuilder: (context, index) {
                                              var imagenProducto =
                                                  obtenerImagenesProducto(
                                                      producto.idProducto,
                                                      imagenesProductos)[index];
                                              return imagenProducto
                                                          .imagenProducto ==
                                                      "Sin imagen"
                                                  ? Text(
                                                      "Sin imagen",
                                                    )
                                                  : Stack(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SizedBox(
                                                            width: 250,
                                                            child: Image.memory(
                                                              convertirBase64ABytes(
                                                                  imagenProducto
                                                                      .imagenProducto),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 0,
                                                          right: 0,
                                                          child: IconButton(
                                                            icon: const Icon(
                                                              Icons
                                                                  .cancel_outlined,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            onPressed: () {
                                                              _deleteImagenByProduct(
                                                                imagenProducto:
                                                                    imagenProducto
                                                                        .idImagen,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                            },
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add,
                                            color: Colors.black),
                                        onPressed: () {
                                          seleccionarImagen(
                                              producto.idProducto);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        obtenerCategoriaProducto(
                                          producto.idProducto,
                                          productosCategorias,
                                        ).categoria.nombre,
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          obtenerCategoriaProducto(
                                                    producto.idProducto,
                                                    productosCategorias,
                                                  ).categoria.nombre ==
                                                  'Sin categoría'
                                              ? Icons.add
                                              : Icons.edit,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          mostrarDialogoCategoria(
                                            context,
                                            categorias,
                                            obtenerCategoriaProducto(
                                              producto.idProducto,
                                              productosCategorias,
                                            ),
                                            producto.idProducto,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(producto.talla.talla),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 100.0,
                                        child: Text(
                                          obtenerPromocionPorProducto(
                                                          producto.idProducto,
                                                          productoPromociones)!
                                                      .promocion!
                                                      .nombre ==
                                                  ''
                                              ? 'Sin promoción'
                                              : obtenerPromocionPorProducto(
                                                      producto.idProducto,
                                                      productoPromociones)!
                                                  .promocion!
                                                  .nombre!,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                            obtenerPromocionPorProducto(
                                                            producto.idProducto,
                                                            productoPromociones)!
                                                        .promocion!
                                                        .nombre !=
                                                    ''
                                                ? Icons.delete
                                                : Icons.add,
                                            color: Colors.black),
                                        onPressed: () {
                                          obtenerPromocionPorProducto(
                                                          producto.idProducto,
                                                          productoPromociones)!
                                                      .promocion!
                                                      .nombre !=
                                                  ''
                                              ? context
                                                  .read<ProductoBloc>()
                                                  .add(
                                                    ProductoPromocionDeleted(
                                                      idProductoPromocion:
                                                          obtenerPromocionPorProducto(
                                                                  producto
                                                                      .idProducto,
                                                                  productoPromociones)!
                                                              .idProductoPromocion!,
                                                    ),
                                                  )
                                              : mostrarDialogoSeleccionPromocion(
                                                  context,
                                                  productoPromociones,
                                                  producto,
                                                );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: const Icon(Icons.edit,
                                        color: Colors.black),
                                    onPressed: () {
                                      setState(() {
                                        _idProducto = producto.idProducto;
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

  Uint8List convertirBase64ABytes(String base64String) {
    return base64Decode(base64String);
  }

  CategoriaPorductoListModel obtenerCategoriaProducto(
    int idProducto,
    List<CategoriaPorductoListModel> categoriasProducto,
  ) {
    var categoriaProducto = categoriasProducto.firstWhere(
      (cp) => cp.producto.idProducto == idProducto,
      orElse: () => CategoriaPorductoListModel(
        idProductoCategoria: 0,
        producto: ProductoC(idProducto: idProducto),
        categoria: Categoria(
          idCategoria: 0,
          nombre: "Sin categoría",
        ),
      ),
    );
    return categoriaProducto;
  }

  List<ImagenProductoModel> obtenerImagenesProducto(
    int idProducto,
    List<ImagenProductoModel> imagenesProducto,
  ) {
    List<ImagenProductoModel> imagenesEncontradas = imagenesProducto
        .where(
          (ip) => ip.producto.idProducto == idProducto,
        )
        .toList();

    if (imagenesEncontradas.isEmpty) {
      imagenesEncontradas.add(
        ImagenProductoModel(
          idImagen: 0,
          imagenProducto: "Sin imagen",
          producto: ProductoI(idProducto: idProducto),
        ),
      );
    }
    return imagenesEncontradas;
  }

  Future<void> seleccionarImagen(
    int idProducto,
  ) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        imagenBytes = result.files.single.bytes;
        imagenBase64 = base64Encode(imagenBytes!);
      });
      _createImagenByProduct(
        productoId: idProducto,
      );
    }
  }

  void mostrarDialogoCategoria(
    BuildContext context,
    List<CategoriaListModel> categorias,
    CategoriaPorductoListModel categoriaSeleccionada,
    int producto,
  ) {
    showDialog(
      context: context,
      builder: (con) {
        String? categoriaSeleccionadaId =
            categoriaSeleccionada.categoria.nombre == 'Sin categoría'
                ? categorias.first.idCategoria.toString()
                : categoriaSeleccionada.categoria.idCategoria.toString();
        return AlertDialog(
          title: Text('Seleccionar Categoría'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: categoriaSeleccionadaId,
                    items: categorias.map((CategoriaListModel categoria) {
                      return DropdownMenuItem<String>(
                        value: categoria.idCategoria.toString(),
                        child: Text(categoria.nombre),
                      );
                    }).toList(),
                    onChanged: (String? nuevoValor) {
                      setState(() {
                        categoriaSeleccionadaId = nuevoValor!;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                categoriaSeleccionada.categoria.nombre == 'Sin categoría'
                    ? context.read<ProductoBloc>().add(
                          CategoriaSaved(
                            idProducto: producto,
                            idCategoria: int.parse(categoriaSeleccionadaId!),
                          ),
                        )
                    : context.read<ProductoBloc>().add(
                          ProductoCategoriaEditedShown(
                            idProducto: producto,
                            idCategoria: int.parse(categoriaSeleccionadaId!),
                            idProductoCategoria:
                                categoriaSeleccionada.idProductoCategoria,
                          ),
                        );
                Navigator.of(context).pop();
              },
              child: Text('Guardar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  ProductoPromocionListModel? obtenerPromocionPorProducto(
      int idProducto, List<ProductoPromocionListModel> productosPromociones) {
    var productoPromocion = productosPromociones.firstWhere(
      (pp) => pp.producto?.idProducto == idProducto,
      orElse: () => ProductoPromocionListModel(
        promocion: Promocion(nombre: ''),
      ),
    );

    return productoPromocion;
  }

  void mostrarDialogoSeleccionPromocion(
    BuildContext context,
    List<ProductoPromocionListModel> promociones,
    ProductoListModel productoSeleccionado,
  ) {
    ProductoPromocionListModel? promocionSeleccionada;

    showDialog(
      context: context,
      builder: (con) {
        return StatefulBuilder(builder: (con, setState) {
          return AlertDialog(
            title: Text(
                "Seleccionar Promoción para ${productoSeleccionado.nombre}"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<ProductoPromocionListModel>(
                  hint: Text("Seleccione una promoción"),
                  value: promocionSeleccionada,
                  onChanged: (ProductoPromocionListModel? newValue) {
                    setState(() {
                      promocionSeleccionada = newValue;
                    });
                  },
                  items: promociones
                      .map<DropdownMenuItem<ProductoPromocionListModel>>(
                          (ProductoPromocionListModel promocion) {
                    return DropdownMenuItem<ProductoPromocionListModel>(
                      value: promocion,
                      child: Text(promocion.promocion!.nombre!),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (promocionSeleccionada != null) {
                      context.read<ProductoBloc>().add(
                            ProductoPromocionSaved(
                              idProducto: productoSeleccionado.idProducto!,
                              idPromocion: promocionSeleccionada!
                                  .promocion!.idPromocion!,
                            ),
                          );
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text("Guardar"),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  void _selectColor() {
    showDialog<Color>(
      context: context,
      builder: (BuildContext con) {
        Color tempColor = Color(0xFFFFFFFF); // Usa el color actual
        return AlertDialog(
          title: Text('Selecciona un color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: tempColor,
              onColorChanged: (Color color) {
                tempColor = color;
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
                child: const Text('Seleccionar'),
                onPressed: () {
                  context.read<ProductoBloc>().add(
                        ColorCreated(
                          color:
                              '0x${tempColor.value.toRadixString(16).toUpperCase()}',
                        ),
                      );
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }
}
