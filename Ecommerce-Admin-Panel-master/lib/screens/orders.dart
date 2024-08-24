import 'package:ecommerce_admin_panel/common/menu_drawer.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final List<Map<String, dynamic>> pedidos = [
    {
      'cliente': 'Juan Pérez',
      'total': 100.0,
      'productos': 3,
      'estado': 'Pendiente',
    },
    {
      'cliente': 'María López',
      'total': 250.5,
      'productos': 5,
      'estado': 'Enviado',
    },
    {
      'cliente': 'Carlos Díaz',
      'total': 75.0,
      'productos': 2,
      'estado': 'Entregado',
    },
  ];

  final Map<String, Color> estadoColor = {
    'Pendiente': Colors.orange,
    'Enviado': Colors.blue,
    'Entregado': Colors.green,
    'Cancelado': Colors.red,
  };

  late List<Map<String, dynamic>> filteredPedidos;

  @override
  void initState() {
    super.initState();
    filteredPedidos = pedidos;
  }

  void _cambiarEstado(int index) async {
    final nuevoEstado = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cambiar estado del pedido'),
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
        filteredPedidos[index]['estado'] = nuevoEstado;
      });
    }
  }

  void _eliminarPedido(int index) {
    setState(() {
      filteredPedidos.removeAt(index);
    });
  }

  void _filterPedidos(String query) {
    setState(() {
      filteredPedidos = pedidos.where((pedido) {
        final clienteLower = pedido['cliente'].toLowerCase();
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
        title: Text('Lista de Pedidos'),
        actions: [
          TextButton.icon(
            onPressed: () {
              // Lógica para agregar un nuevo pedido
            },
            icon: Icon(Icons.add, color: Colors.white),
            label: Text(
              'Agregar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
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
            margin: EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar pedidos...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    onChanged: _filterPedidos,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Table(
                      border: TableBorder.all(color: Colors.grey),
                      columnWidths: {
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
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Cliente',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Total',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Productos',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Estado',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Cambiar Estado',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                child: Text(pedido['cliente']),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('\$${pedido['total']}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${pedido['productos']}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: estadoColor[pedido['estado']],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    pedido['estado'],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  icon:
                                      Icon(Icons.refresh, color: Colors.black),
                                  onPressed: () => _cambiarEstado(
                                      filteredPedidos.indexOf(pedido)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.black),
                                  onPressed: () => _eliminarPedido(
                                      filteredPedidos.indexOf(pedido)),
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
    );
  }
}
