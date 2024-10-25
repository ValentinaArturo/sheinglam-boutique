import 'package:ecommerce_admin_panel/common/bloc/base_state.dart';
import 'package:ecommerce_admin_panel/common/dialog/custom_state_dialog.dart';
import 'package:ecommerce_admin_panel/common/loader/loader.dart';
import 'package:ecommerce_admin_panel/common/menu_drawer.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/proveedor_list_model.dart';
import 'package:ecommerce_admin_panel/screens/proveedores/bloc/proveedor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProveedorPage extends StatelessWidget {
  const ProveedorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProveedorBloc(),
      child: const ProveedorBody(),
    );
  }
}

class ProveedorBody extends StatefulWidget {
  const ProveedorBody({super.key});

  @override
  State<ProveedorBody> createState() => _ProveedorBodyState();
}

class _ProveedorBodyState extends State<ProveedorBody> {
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _direccion = TextEditingController();
  final TextEditingController _telefono = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _nit = TextEditingController();

  List<ProveedorListModel> proveedores = [];
  late List<ProveedorListModel> filteredProveedores = [];

  bool _isLoading = false;
  late int? _idProveedor;

  @override
  void initState() {
    _idProveedor = null;
    _getProveedores();
    super.initState();
  }

  void _getProveedores() {
    context.read<ProveedorBloc>().add(
          ProveedorShown(),
        );
  }

  void _createProveedor() {
    context.read<ProveedorBloc>().add(
          ProveedorCreated(
            nombre: _nombre.text,
            direccion: _direccion.text,
            telefono: _telefono.text,
            email: _email.text,
            nit: _nit.text,
          ),
        );
  }

  void _editProveedor() {
    context.read<ProveedorBloc>().add(
          ProveedorEdited(
            id: _idProveedor!,
            nombre: _nombre.text,
            direccion: _direccion.text,
            telefono: _telefono.text,
            email: _email.text,
            nit: _nit.text,
          ),
        );
  }

  void _deleteProveedor() {
    context.read<ProveedorBloc>().add(
          ProveedorDeleted(
            id: _idProveedor!,
          ),
        );
  }

  void _filterProductos(String query) {
    final results = proveedores.where((producto) {
      final tituloLower = producto.nombre.toLowerCase();
      final queryLower = query.toLowerCase();
      return tituloLower.contains(queryLower);
    }).toList();

    setState(() {
      proveedores = results;
    });
  }

  void _showProveedorModal([bool isEdit = false]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isEdit ? 'Editar Proveedor' : 'Agregar Proveedor'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                controller: _nombre,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Dirección'),
                controller: _direccion,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Teléfono'),
                controller: _telefono,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Email'),
                controller: _email,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'NIT'),
                controller: _nit,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (isEdit) {
                  _editProveedor();
                } else {
                  _createProveedor();
                }
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

  void _showDeleteModal(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar Proveedor'),
          content: const Text(
              '¿Deseas eliminar este proveedor? Esta acción no se puede deshacer.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _deleteProveedor();
                Navigator.of(context).pop();
              },
              child: const Text('Eliminar'),
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
        title: const Text('Lista de Proveedores'),
        actions: [
          TextButton.icon(
            onPressed: () {
              _nombre.clear();
              _direccion.clear();
              _telefono.clear();
              _email.clear();
              _nit.clear();
              _createProveedor();
            },
            icon: const Icon(Icons.add, color: Colors.black),
            label: const Text(
              'Agregar',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: BlocListener<ProveedorBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (ProveedorInProgress):
              setState(() => _isLoading = true);
              break;
            case const (ProveedorListSuccess):
              final loadedState = state as ProveedorListSuccess;
              setState(() {
                _isLoading = false;
                proveedores = loadedState.proveedores;
                filteredProveedores = loadedState.proveedores;
              });
              break;
            case const (ProveedorCreatedSuccess):
              _getProveedores();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Proveedores',
                description: "Proveedor creada correctamente",
              );
              break;
            case const (ProveedorEditedSuccess):
              _getProveedores();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Proveedors',
                description: "Proveedor editada correctamente",
              );
              break;
            case const (ProveedorDeletedSuccess):
              _getProveedores();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Proveedors',
                description: "Proveedor borrada correctamente",
              );
              break;
            case const (ProveedorError):
              final stateError = state as ProveedorError;
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Proveedor',
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
              margin: const EdgeInsets.symmetric(horizontal: 150.0),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Buscar proveedores...',
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
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Table(
                          border: TableBorder.all(color: Colors.grey),
                          columnWidths: const {
                            0: FlexColumnWidth(3),
                            1: FixedColumnWidth(100),
                            2: FixedColumnWidth(100),
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
                                    'Nombre',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Editar',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Eliminar',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            ...filteredProveedores.map((proveedor) {
                              return TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(proveedor.nombre),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.black),
                                      onPressed: () {
                                        _idProveedor = proveedor.idProveedor;
                                        _nombre.text = proveedor.nombre;
                                        _showProveedorModal(true);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.black),
                                      onPressed: () => _showDeleteModal(proveedor.idProveedor)
                                      ,
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
