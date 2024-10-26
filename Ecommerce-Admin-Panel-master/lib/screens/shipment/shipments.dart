import 'package:ecommerce_admin_panel/common/menu_drawer.dart';
import 'package:ecommerce_admin_panel/screens/shipment/bloc/shipment_bloc.dart';
import 'package:ecommerce_admin_panel/screens/shipment/model/detalle_factura_list_model.dart';
import 'package:ecommerce_admin_panel/screens/shipment/model/factura_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  late List<FacturaListModel> _filteredfactura = [];

  @override
  void initState() {
    super.initState();

  }
  void _filterEnvios(String query) {
    setState(() {
      _filteredfactura = _facturas.where((factura) {
        final nombreLower = factura.pedido!.cliente!.usuario!.correoElectronico!.toLowerCase();
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
        actions: [],
      ),
      body: Stack(
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
                      hintText: 'Buscar facturas por nit o correo de usuario...',
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Departamento',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Precio',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          ..._filteredfactura.map((factura) {
                            return TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(factura.pedido?.cliente?.usuario?.nombre ?? 'Sin nombre'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(factura.pedido?.nit ?? 'Sin departamento'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('\$${factura.total?.toStringAsFixed(2) ?? '0.00'}'),
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
        ],
      ),
    );
  }
}
