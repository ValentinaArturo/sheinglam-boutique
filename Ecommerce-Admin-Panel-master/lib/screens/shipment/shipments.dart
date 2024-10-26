import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:ecommerce_admin_panel/common/bloc/base_state.dart';
import 'package:ecommerce_admin_panel/common/dialog/custom_state_dialog.dart';
import 'package:ecommerce_admin_panel/common/loader/loader.dart';
import 'package:ecommerce_admin_panel/common/menu_drawer.dart';
import 'package:ecommerce_admin_panel/screens/shipment/bloc/shipment_bloc.dart';
import 'package:ecommerce_admin_panel/screens/shipment/model/detalle_factura_list_model.dart';
import 'package:ecommerce_admin_panel/screens/shipment/model/factura_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ShipmentPage extends StatelessWidget {
  const ShipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShipmentBloc(),
      child: const ShipmentsScreen(),
    );
  }
}

class ShipmentsScreen extends StatefulWidget {
  const ShipmentsScreen({super.key});

  @override
  _ShipmentsScreenState createState() => _ShipmentsScreenState();
}

class _ShipmentsScreenState extends State<ShipmentsScreen> {
  List<FacturaListModel> _facturas = [];
  List<DetalleFacturaListModel> _detalleFacturas = [];
  bool _isLoading = false;

  late List<FacturaListModel> _filteredfactura = [];

  @override
  void initState() {
    _fetchFacturas();
    _fetchDetalleFacturas();
    super.initState();
  }

  void _fetchFacturas() {
    context.read<ShipmentBloc>().add(
          FacturasShown(),
        );
  }

  void _fetchDetalleFacturas() {
    context.read<ShipmentBloc>().add(
          DetalleFacturasShown(),
        );
  }

  void _filterEnvios(String query) {
    setState(() {
      _filteredfactura = _facturas.where((factura) {
        final nombreLower =
            factura.pedido!.cliente!.usuario!.correoElectronico!.toLowerCase();
        final departamentoLower = factura.pedido!.nit.toString();
        final queryLower = query.toLowerCase();

        return nombreLower.contains(queryLower) ||
            departamentoLower.contains(queryLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      appBar: AppBar(
        title: Text('Lista de facturas'),
      ),
      body: BlocListener<ShipmentBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (ShipmentInProgress):
              setState(() => _isLoading = true);
              break;
            case const (ShipmentFacturaSuccess):
              final loadedState = state as ShipmentFacturaSuccess;
              setState(() {
                _isLoading = false;
                _facturas = loadedState.facturas;
                _filteredfactura = loadedState.facturas;
              });
              break;
            case const (ShipmentDetalleFacturaSuccess):
              final loadedState = state as ShipmentDetalleFacturaSuccess;
              setState(() {
                _isLoading = false;
                _detalleFacturas = loadedState.detalleFacturas;
              });
              break;
            case const (ShipmentPedidosError):
              final stateError = state as ShipmentPedidosError;
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Facturas',
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
                        hintText:
                            'Buscar facturas por nit o correo de usuario...',
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
                      onChanged: _filterEnvios,
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Table(
                          border: TableBorder.all(color: Colors.grey),
                          columnWidths: const {
                            0: FlexColumnWidth(3),
                            1: FlexColumnWidth(2),
                            2: FlexColumnWidth(2),
                            3: FlexColumnWidth(2),
                            4: FlexColumnWidth(2),
                            5: FlexColumnWidth(2),
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
                                    'Departamento',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Precio',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Fecha',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Cantidad',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Descargar',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            ..._filteredfactura.map((factura) {
                              return TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(factura
                                            .pedido?.cliente?.usuario?.nombre ??
                                        'Sin nombre'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(factura.pedido?.nit ??
                                        'Sin departamento'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        '\$${factura.total?.toStringAsFixed(2) ?? '0.00'}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(DateFormat(
                                          "dd 'de' MMM 'de' yyyy, HH:mm",
                                        ).format(DateTime.parse(
                                            factura.pedido!.fecha!)) ??
                                        '------'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      buscarDetallePorIdFactura(
                                              factura.idFactura!,
                                              _detalleFacturas)!
                                          .cantidad
                                          .toString(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                      icon: const Icon(Icons.arrow_circle_down,
                                          color: Colors.black),
                                      onPressed: () => generatePdf(
                                        factura,
                                        buscarDetallePorIdFactura(
                                            factura.idFactura!,
                                            _detalleFacturas)!,
                                      ),
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

  DetalleFacturaListModel? buscarDetallePorIdFactura(
      int idFactura, List<DetalleFacturaListModel> detallesFacturas) {
    return detallesFacturas.firstWhere(
      (detalle) => detalle.factura?.idFactura == idFactura,
      orElse: () =>
          DetalleFacturaListModel(), // Devuelve null si no encuentra un detalle.
    );
  }

  void generatePdf(
      FacturaListModel factura, DetalleFacturaListModel detalle) async {
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
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Factura #${factura.idFactura}',
                style: pw.TextStyle(fontSize: 24, font: font),
              ),
              pw.SizedBox(height: 10),

              // Información de la factura
              pw.Text('Fecha: ${factura.fecha}',
                  style: pw.TextStyle(font: font)),
              pw.Text(
                  'Cliente: ${factura.pedido!.cliente!.usuario!.nombre} ${factura.pedido!.cliente!.usuario!.apellido}',
                  style: pw.TextStyle(font: font)),
              pw.Text(
                  'Correo: ${factura.pedido!.cliente!.usuario!.correoElectronico}',
                  style: pw.TextStyle(font: font)),
              pw.SizedBox(height: 20),

              // Tabla de detalles de la factura
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  // Encabezados de la tabla
                  pw.TableRow(children: [
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Producto',
                            style: pw.TextStyle(font: font))),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Cantidad',
                            style: pw.TextStyle(font: font))),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Precio Unitario',
                            style: pw.TextStyle(font: font))),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Subtotal',
                            style: pw.TextStyle(font: font))),
                  ]),

                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('${detalle.producto?.nombre}',
                            style: pw.TextStyle(font: font)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('${detalle.cantidad}',
                            style: pw.TextStyle(font: font)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('${detalle.precioUnitario}',
                            style: pw.TextStyle(font: font)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('${detalle.subtotal}',
                            style: pw.TextStyle(font: font)),
                      ),
                    ],
                  )
                ],
              ),

              // Espacio y total de la factura
              pw.SizedBox(height: 20),
              pw.Text('Total: ${factura.total}',
                  style: pw.TextStyle(fontSize: 18, font: font)),
            ],
          );
        },
      ),
    );

    // Guardar y descargar el PDF
    Uint8List savedFile = await pdf.save();
    List<int> fileInts = List<int>.from(savedFile);
    html.AnchorElement(
      href: 'data:application/octet-stream;charset=utf-16le;base64,'
          '${base64.encode(fileInts)}',
    )
      ..setAttribute('download',
          'factura-${factura.idFactura}-${DateTime.now().millisecondsSinceEpoch}.pdf')
      ..click();
  }
}
