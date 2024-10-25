import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:ecommerce_admin_panel/common/bloc/base_state.dart';
import 'package:ecommerce_admin_panel/common/dialog/custom_state_dialog.dart';
import 'package:ecommerce_admin_panel/common/loader/loader.dart';
import 'package:ecommerce_admin_panel/common/menu_drawer.dart';
import 'package:ecommerce_admin_panel/screens/ordenes/bloc/orden_bloc.dart';
import 'package:ecommerce_admin_panel/screens/ordenes/model/orden_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdenBloc(),
      child: const OrdersScreen(),
    );
  }
}

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final Map<String, Color> estadoColor = {
    'Pendiente': Colors.orange,
    'Enviado': Colors.blue,
    'Entregado': Colors.green,
    'Cancelado': Colors.red,
  };

  List<OrdenListModel> pedidos = [];
  List<OrdenListModel> filteredPedidos = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadPedidos();
  }

  void _loadPedidos() {
    context.read<OrdenBloc>().add(
          OrdenShown(),
        );
  }

  void _cambiarEstado({required OrdenListModel pedido}) async {
    final nuevoEstado = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cambiar estado del pedido'),
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
      final List<String> keys = estadoColor.keys.toList();
      final int index = keys.indexOf(nuevoEstado) + 1;
      _editarPedido(pedido: pedido, newIdEstao: index);
    }
  }

  void _eliminarPedido({required int id}) {
    context.read<OrdenBloc>().add(
          OrdenDeleted(id: id),
        );
  }

  void _editarPedido({
    required OrdenListModel pedido,
    required int newIdEstao,
  }) {
    context.read<OrdenBloc>().add(OrdenEdited(
          id: pedido.idPedidoEstado,
          idPedido: pedido.pedido.idPedido,
          idEstadoPedido: newIdEstao,
          fecha: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        ));
  }

  void _filterPedidos(String query) {
    setState(() {
      filteredPedidos = pedidos.where((pedido) {
        final clienteLower = pedido.pedido.cliente.usuario.nombre.toLowerCase();
        final queryLower = query.toLowerCase();

        return clienteLower.contains(queryLower);
      }).toList();
    });
  }

  void _showdeleteModal({required int id}) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar Pedido'),
          content: const Text(
            'Confirma que desas eliminar este pedido, todos los datos se perderán.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _eliminarPedido(id: id);
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  void generatePdf(List<OrdenListModel> orders) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.crimsonTextRegular();

    pdf.addPage(
      pw.Page(
        theme: pw.ThemeData.withFont(
          base: pw.Font.helvetica(),
          bold: pw.Font.helvetica(),
          italic: pw.Font.helvetica(),
        ),
        pageFormat: PdfPageFormat.letter,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Reporte de Órdenes',
                  style: pw.TextStyle(fontSize: 24, font: font)),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  // Encabezados de la tabla
                  pw.TableRow(children: [
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('ID Pedido Estado',
                            style: pw.TextStyle(font: font))),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('ID Pedido',
                            style: pw.TextStyle(font: font))),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Nombre Cliente',
                            style: pw.TextStyle(font: font))),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Estado Pedido',
                            style: pw.TextStyle(font: font))),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child:
                            pw.Text('Fecha', style: pw.TextStyle(font: font))),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child:
                            pw.Text('Total', style: pw.TextStyle(font: font))),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Método de Pago',
                            style: pw.TextStyle(font: font))),
                  ]),
                  // Filas de datos
                  ...orders.map((order) {
                    return pw.TableRow(
                      children: [
                        pw.Text('${order.idPedidoEstado}',
                            style: pw.TextStyle(font: font)),
                        pw.Text('${order.pedido.idPedido}',
                            style: pw.TextStyle(font: font)),
                        pw.Text(
                            '${order.pedido.cliente.usuario.nombre} ${order.pedido.cliente.usuario.apellido}',
                            style: pw.TextStyle(font: font)),
                        pw.Text('${order.estadoPedido.nombre}',
                            style: pw.TextStyle(font: font)),
                        pw.Text('${order.fecha}',
                            style: pw.TextStyle(font: font)),
                        pw.Text('${order.pedido.total.toStringAsFixed(2)}',
                            style: pw.TextStyle(font: font)),
                        pw.Text('${order.pedido.metodoPago.nombre}',
                            style: pw.TextStyle(font: font)),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ],
          );
        },
      ),
    );

    // Guardar el archivo PDF
    Uint8List savedFile = await pdf.save();
    List<int> fileInts = List<int>.from(savedFile);
    html.AnchorElement(
      href: 'data:application/octet-stream;charset=utf-16le;base64,'
          '${base64.encode(fileInts)}',
    )
      ..setAttribute(
          'download', 'ordenes-${DateTime.now().millisecondsSinceEpoch}.pdf')
      ..click();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      appBar: AppBar(
        title: const Text('Lista de Pedidos'),
        actions: [
          ElevatedButton(
            onPressed: () {
              generatePdf(pedidos);
            },
            child: const Text('Generar Reporte'),
          ),
        ],
      ),
      body: BlocListener<OrdenBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (OrdenInProgress):
              setState(() => _isLoading = true);
              break;
            case const (OrdenSuccess):
              final loadedState = state as OrdenSuccess;
              setState(() {
                _isLoading = false;
                pedidos = loadedState.ordenes;
                filteredPedidos = loadedState.ordenes;
              });
              break;
            case const (OrdenCreatedSuccess):
              _loadPedidos();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Ordens',
                description: "Orden creado correctamente",
              );
              break;
            case const (OrdenEditedSuccess):
              _loadPedidos();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Ordens',
                description: "Orden editado correctamente",
              );
              break;
            case const (OrdenDeletedSuccess):
              _loadPedidos();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Ordens',
                description: "Orden borrado correctamente",
              );
              break;
            case const (OrdenError):
              final stateError = state as OrdenError;
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Ordens',
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
                        hintText: 'Buscar pedidos...',
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
                      onChanged: _filterPedidos,
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
                          3: FixedColumnWidth(100),
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
                                  'Nit',
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
                          ...filteredPedidos.map((pedido) {
                            return TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${pedido.pedido.cliente.usuario.nombre}'
                                    '${pedido.pedido.cliente.usuario.apellido}',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('\$${pedido.pedido.total}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(pedido.pedido.nit),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: estadoColor[
                                          pedido.estadoPedido.nombre],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      pedido.estadoPedido.nombre,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: const Icon(Icons.refresh,
                                        color: Colors.black),
                                    onPressed: () => _cambiarEstado(
                                      pedido: pedido,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.black),
                                    onPressed: () => _showdeleteModal(
                                      id: pedido.idPedidoEstado,
                                    ),
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
