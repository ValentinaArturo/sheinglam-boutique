import 'package:ecommerce_admin_panel/common/menu_drawer.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final List<Map<String, String>> productos = [
    {
      'titulo': 'Producto 1',
      'descripcion': 'Descripción del producto 1',
      'categoria': 'Categoría 1',
      'talla': 'M',
    },
    {
      'titulo': 'Producto 2',
      'descripcion': 'Descripción del producto 2',
      'categoria': 'Categoría 2',
      'talla': 'L',
    },
    {
      'titulo': 'Producto 3',
      'descripcion': 'Descripción del producto 3',
      'categoria': 'Categoría 3',
      'talla': 'S',
    },
  ];

  List<Map<String, String>> filteredProductos = [];

  @override
  void initState() {
    super.initState();
    filteredProductos = productos;
  }

  void _filterProductos(String query) {
    final results = productos.where((producto) {
      final tituloLower = producto['titulo']!.toLowerCase();
      final queryLower = query.toLowerCase();

      return tituloLower.contains(queryLower);
    }).toList();

    setState(() {
      filteredProductos = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      appBar: AppBar(
        title: Text('Lista de Productos'),
        actions: [
          TextButton.icon(
            onPressed: () {
              // Lógica para agregar un nuevo producto
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
                      hintText: 'Buscar productos...',
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
                    onChanged: _filterProductos,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Table(
                      border: TableBorder.all(color: Colors.grey),
                      columnWidths: {
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
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Título',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Descripción',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Categoría',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Talla',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Editar',
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
                        ...filteredProductos.map((producto) {
                          return TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(producto['titulo']!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(producto['descripcion']!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(producto['categoria']!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(producto['talla']!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  icon: Icon(Icons.edit, color: Colors.black),
                                  onPressed: () {
                                    // Lógica para editar el producto
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.black),
                                  onPressed: () {
                                    // Lógica para eliminar el producto
                                  },
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
