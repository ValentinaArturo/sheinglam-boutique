import 'package:ecommerce_admin_panel/common/menu_drawer.dart';
import 'package:flutter/material.dart';

class ReturnsScreen extends StatefulWidget {
  @override
  _ReturnsScreenState createState() => _ReturnsScreenState();
}

class _ReturnsScreenState extends State<ReturnsScreen> {
  final List<Map<String, dynamic>> devoluciones = [
    {
      'cliente': 'Juan Pérez',
      'total': 100.0,
      'productos': 'Camiseta, Pantalones',
      'razonDevolucion': 'Producto defectuoso',
      'descripcion': 'La camiseta tiene un agujero.',
      'estado': 'Pendiente',
    },
    {
      'cliente': 'María López',
      'total': 250.5,
      'productos': 'Zapatos, Bolso',
      'razonDevolucion': 'Talla incorrecta',
      'descripcion': 'Los zapatos son muy grandes.',
      'estado': 'Enviado',
    },
    {
      'cliente': 'Carlos Díaz',
      'total': 75.0,
      'productos': 'Sombrero',
      'razonDevolucion': 'No coincide con la descripción',
      'descripcion':
          'El sombrero es de un color diferente al mostrado en la tienda.',
      'estado': 'Entregado',
    },
  ];

  final Map<String, Color> estadoColor = {
    'Pendiente': Colors.orange,
    'Enviado': Colors.blue,
    'Entregado': Colors.green,
    'Cancelado': Colors.red,
  };

  late List<Map<String, dynamic>> filteredDevoluciones;

  @override
  void initState() {
    super.initState();
    filteredDevoluciones = devoluciones;
  }

  void _cambiarEstado(int index) async {
    final nuevoEstado = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cambiar estado del devolución'),
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
        filteredDevoluciones[index]['estado'] = nuevoEstado;
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
        final clienteLower = devolucion['cliente'].toLowerCase();
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
        title: Text('Lista de Devoluciones'),
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
                      hintText: 'Buscar devoluciones...',
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
                    onChanged: _filterDevoluciones,
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
                                'Razón de Devolución',
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
                        ...filteredDevoluciones.map((devolucion) {
                          return TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(devolucion['cliente']),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('\$${devolucion['total']}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(devolucion['productos']),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(devolucion['razonDevolucion']),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 10),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: estadoColor[devolucion['estado']],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      devolucion['estado'],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  icon: Icon(Icons.refresh, color: Colors.black),
                                  onPressed: () => _cambiarEstado(
                                      filteredDevoluciones.indexOf(devolucion)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.black),
                                  onPressed: () => _eliminarDevolucion(
                                      filteredDevoluciones.indexOf(devolucion)),
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
