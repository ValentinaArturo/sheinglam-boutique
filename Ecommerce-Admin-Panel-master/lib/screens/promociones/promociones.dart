import 'package:ecommerce_admin_panel/common/bloc/base_state.dart';
import 'package:ecommerce_admin_panel/common/dialog/custom_state_dialog.dart';
import 'package:ecommerce_admin_panel/common/loader/loader.dart';
import 'package:ecommerce_admin_panel/common/menu_drawer.dart';
import 'package:ecommerce_admin_panel/screens/promociones/bloc/promociones_bloc.dart';
import 'package:ecommerce_admin_panel/screens/promociones/model/promociones_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PromocionesPage extends StatelessWidget {
  const PromocionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PromocionesBloc(),
      child: const PromocionesBody(),
    );
  }
}

class PromocionesBody extends StatefulWidget {
  const PromocionesBody({super.key});

  @override
  State<PromocionesBody> createState() => _PromocionesBodyState();
}

class _PromocionesBodyState extends State<PromocionesBody> {
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _descripcion = TextEditingController();
  final TextEditingController _descuento = TextEditingController();

  List<PromocionListModel> promociones = [];
  List<PromocionListModel> filteredPromociones = [];

  bool _isLoading = false;
  late int? _idPromociones;

  @override
  void initState() {
    _idPromociones = null;
    _getPromocioneses();
    super.initState();
  }

  void _getPromocioneses() {
    context.read<PromocionesBloc>().add(
          PromocionesShown(),
        );
  }

  void _createPromociones() {
    context.read<PromocionesBloc>().add(
          PromocionesCreated(
            nombre: _nombre.text,
            descripcion: _descripcion.text,
            descuento: double.parse(_descuento.text),
          ),
        );
  }

  void _editPromociones() {
    context.read<PromocionesBloc>().add(
          PromocionesEdited(
            id: _idPromociones!,
            nombre: _nombre.text,
            descripcion: _descripcion.text,
            descuento: double.parse(_descuento.text),
          ),
        );
  }

  void _deletePromociones() {
    context.read<PromocionesBloc>().add(
          PromocionesDeleted(
            id: _idPromociones!,
          ),
        );
  }

  void _filterProductos(String query) {
    final results = promociones.where((producto) {
      final tituloLower = producto.nombre!.toLowerCase();
      final queryLower = query.toLowerCase();
      return tituloLower.contains(queryLower);
    }).toList();

    setState(() {
      promociones = results;
    });
  }

  void _filterPromociones(String query) {
    setState(() {
      filteredPromociones = promociones.where((promocion) {
        final nombreLower = promocion.nombre!.toLowerCase();
        final queryLower = query.toLowerCase();
        return nombreLower.contains(queryLower);
      }).toList();
    });
  }

  void _showPromocionModal([bool isEdit = false]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isEdit ? 'Editar Promoción' : 'Agregar Promoción'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                controller: _nombre,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Descripción'),
                controller: _descripcion,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Descuento (%)'),
                controller: _descuento,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (isEdit) {
                  _editPromociones();
                } else {
                  _createPromociones();
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
          title: const Text('Eliminar Promoción'),
          content: const Text(
              '¿Deseas eliminar esta promoción? Esta acción no se puede deshacer.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _deletePromociones();
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
        title: const Text('Lista de Promociones'),
        actions: [
          TextButton.icon(
            onPressed: () {
              _nombre.clear();
              _descripcion.clear();
              _descuento.clear();
              _showPromocionModal();
            },
            icon: const Icon(Icons.add, color: Colors.black),
            label: const Text(
              'Agregar',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: BlocListener<PromocionesBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (PromocionesInProgress):
              setState(() => _isLoading = true);
              break;
            case const (PromocionesListSuccess):
              final loadedState = state as PromocionesListSuccess;
              setState(() {
                _isLoading = false;
                promociones = loadedState.promociones;
                filteredPromociones = loadedState.promociones;
              });
              break;
            case const (PromocionesCreatedSuccess):
              _getPromocioneses();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Promocioneses',
                description: "Promociones creada correctamente",
              );
              break;
            case const (PromocionesEditedSuccess):
              _getPromocioneses();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Promocioness',
                description: "Promociones editada correctamente",
              );
              break;
            case const (PromocionesDeletedSuccess):
              _getPromocioneses();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Promocioness',
                description: "Promociones borrada correctamente",
              );
              break;
            case const (PromocionesError):
              final stateError = state as PromocionesError;
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Promociones',
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
                        hintText: 'Buscar promociones...',
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
                      onChanged: _filterPromociones,
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
                            ...filteredPromociones.map((promocion) {
                              return TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(promocion.nombre ?? ''),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.black),
                                      onPressed: () {
                                        _idPromociones = promocion.idPromocion;
                                        _nombre.text = promocion.nombre!;
                                        _descripcion.text =
                                            promocion.descripcion!;
                                        _descuento.text =
                                            promocion.descuento.toString();
                                        _showPromocionModal(true);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.black),
                                      onPressed: () => _showDeleteModal(
                                          promocion.idPromocion!),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
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
