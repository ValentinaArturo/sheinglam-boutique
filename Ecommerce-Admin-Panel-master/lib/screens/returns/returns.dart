import 'package:ecommerce_admin_panel/common/bloc/base_state.dart';
import 'package:ecommerce_admin_panel/common/dialog/custom_state_dialog.dart';
import 'package:ecommerce_admin_panel/common/menu_drawer.dart';
import 'package:ecommerce_admin_panel/screens/returns/bloc/return_bloc.dart';
import 'package:ecommerce_admin_panel/screens/returns/model/return_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReturnPage extends StatelessWidget {
  const ReturnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReturnBloc(),
      child: const ReturnsScreen(),
    );
  }
}

class ReturnsScreen extends StatefulWidget {
  const ReturnsScreen({super.key});

  @override
  State<ReturnsScreen> createState() => _ReturnsScreenState();
}

class _ReturnsScreenState extends State<ReturnsScreen> {
  final TextEditingController _idPedido = TextEditingController();
  final TextEditingController _motivo = TextEditingController();
  final TextEditingController _fechaDevolucion = TextEditingController();
  final TextEditingController _estado = TextEditingController();

  List<ReturnListModel> devoluciones = [];
  late List<ReturnListModel> filteredDevoluciones;

  final Map<String, Color> estadoColor = {
    'Pendiente': Colors.orange,
    'Enviado': Colors.blue,
    'Entregado': Colors.green,
    'Cancelado': Colors.red,
  };

  bool _isLoading = false;
  late int? _idReturn;

  @override
  void initState() {
    super.initState();
    _idReturn = null;
    _getReturnList();
  }

  void _getReturnList() {
    context.read<ReturnBloc>().add(
          ReturnShown(),
        );
  }

  void _createReturn() {
    context.read<ReturnBloc>().add(
          ReturnCreated(
            idPedido: int.parse(_idPedido.text),
            motivo: _motivo.text,
            fechaDevolucion: _fechaDevolucion.text,
            estado: _estado.text,
          ),
        );
  }

  void _editReturn() {
    context.read<ReturnBloc>().add(
          ReturnEdited(
            id: _idReturn!,
            idPedido: int.parse(_idPedido.text),
            motivo: _motivo.text,
            fechaDevolucion: _fechaDevolucion.text,
            estado: _estado.text,
          ),
        );
  }

  void _deleteReturn() {
    context.read<ReturnBloc>().add(
          ReturnDeleted(
            id: _idReturn!,
          ),
        );
  }

  void _cambiarEstado(int index) async {
    final nuevoEstado = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cambiar estado del devolución'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: estadoColor.keys.map((estado) {
              return ListTile(
                title: Text(estado),
                onTap: () {
                  Navigator.of(context).pop(estado);
                },
              );
            }).toList(),
          ),
        );
      },
    );

    if (nuevoEstado != null && nuevoEstado.isNotEmpty) {
      setState(() {
        // filteredDevoluciones[index]['estado'] = nuevoEstado;
      });
    }
  }

  void _eliminarDevolucion(int index) {
    setState(() {
      filteredDevoluciones.removeAt(index);
    });
  }

  void _filterDevoluciones(String query) {
    setState(() {
      filteredDevoluciones = devoluciones.where((devolucion) {
        final clienteLower =
            devolucion.pedido!.cliente!.usuario!.nombre!.toLowerCase();
        final queryLower = query.toLowerCase();

        return clienteLower.contains(queryLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      appBar: AppBar(
        title: const Text('Lista de Devoluciones'),
      ),
      body: BlocListener<ReturnBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (ReturnInProgress):
              setState(() => _isLoading = true);
              break;
            case const (ReturnListSuccess):
              final loadedState = state as ReturnListSuccess;
              setState(() {
                _isLoading = false;
                devoluciones = loadedState.proveedores;
                filteredDevoluciones = loadedState.proveedores;
              });
              break;
            case const (ReturnCreatedSuccess):
              _getReturnList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Returnes',
                description: "Return creada correctamente",
              );
              break;
            case const (ReturnEditedSuccess):
              _getReturnList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Returns',
                description: "Return editada correctamente",
              );
              break;
            case const (ReturnDeletedSuccess):
              _getReturnList();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Returns',
                description: "Return borrada correctamente",
              );
              break;
            case const (ReturnError):
              final stateError = state as ReturnError;
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
              margin: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Buscar devoluciones...',
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
                      onChanged: _filterDevoluciones,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Table(
                        border: TableBorder.all(color: Colors.grey),
                        columnWidths: const {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(2),
                          2: FlexColumnWidth(2),
                          3: FlexColumnWidth(4),
                          4: FlexColumnWidth(3),
                          5: FixedColumnWidth(120),
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
                                  'Cliente',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Total',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Productos',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Razón de Devolución',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Estado',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Cambiar Estado',
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
                          ...filteredDevoluciones.map((devolucion) {
                            return TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    devolucion
                                        .pedido!.cliente!.usuario!.nombre!,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('\$${devolucion.pedido!.total}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    devolucion.pedido!.metodoPago!.nombre!,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(devolucion.motivo!),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 10),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: estadoColor[devolucion.estado],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        devolucion.estado!,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: const Icon(Icons.refresh,
                                        color: Colors.black),
                                    onPressed: () => _cambiarEstado(
                                        filteredDevoluciones
                                            .indexOf(devolucion)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.black),
                                    onPressed: () => _eliminarDevolucion(
                                        filteredDevoluciones
                                            .indexOf(devolucion)),
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
          ],
        ),
      ),
    );
  }
}
