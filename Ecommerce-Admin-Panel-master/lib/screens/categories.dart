import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final List<Map<String, String>> categorias = [
    {
      'nombre': 'Categoría 1',
      'descripcion': 'Descripción de la categoría 1',
    },
    {
      'nombre': 'Categoría 2',
      'descripcion': 'Descripción de la categoría 2',
    },
    {
      'nombre': 'Categoría 3',
      'descripcion': 'Descripción de la categoría 3',
    },
  ];

  late List<Map<String, String>> filteredCategorias;

  @override
  void initState() {
    super.initState();
    filteredCategorias = categorias;
  }

  void _agregarCategoria(BuildContext context) {
    _showCategoryModal(context);
  }

  void _editarCategoria(BuildContext context, int index) {
    _showCategoryModal(context, categoria: filteredCategorias[index], index: index);
  }

  void _eliminarCategoria(int index) {
    setState(() {
      filteredCategorias.removeAt(index);
    });
  }

  void _filterCategorias(String query) {
    setState(() {
      filteredCategorias = categorias.where((categoria) {
        final nombreLower = categoria['nombre']!.toLowerCase();
        final descripcionLower = categoria['descripcion']!.toLowerCase();
        final queryLower = query.toLowerCase();

        return nombreLower.contains(queryLower) || descripcionLower.contains(queryLower);
      }).toList();
    });
  }

  void _showCategoryModal(BuildContext context, {Map<String, String>? categoria, int? index}) {
    String nombre = categoria?['nombre'] ?? '';
    String descripcion = categoria?['descripcion'] ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(categoria == null ? 'Agregar Categoría' : 'Editar Categoría'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Nombre'),
                controller: TextEditingController(text: nombre),
                onChanged: (value) {
                  nombre = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Descripción'),
                controller: TextEditingController(text: descripcion),
                onChanged: (value) {
                  descripcion = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (categoria == null) {
                  // Agregar nueva categoría
                  setState(() {
                    categorias.add({'nombre': nombre, 'descripcion': descripcion});
                    filteredCategorias = categorias;
                  });
                } else {
                  // Editar categoría existente
                  setState(() {
                    filteredCategorias[index!] = {'nombre': nombre, 'descripcion': descripcion};
                    categorias[categorias.indexOf(categoria)] = {'nombre': nombre, 'descripcion': descripcion};
                  });
                }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Categorías'),
        actions: [
          TextButton.icon(
            onPressed: () => _agregarCategoria(context),
            icon: Icon(Icons.add, color: Colors.black),
            label: Text(
              'Agregar',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              'assets/images/fondo_agua.jpg', // Ruta de tu imagen de fondo
              fit: BoxFit.cover,
            ),
          ),
          // Contenido principal
          Container(
            margin: EdgeInsets.symmetric(horizontal: 150.0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar categorías...',
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
                    onChanged: _filterCategorias,
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Table(
                        border: TableBorder.all(color: Colors.grey),
                        columnWidths: {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(4),
                          2: FixedColumnWidth(100),
                          3: FixedColumnWidth(100),
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
                                  'Nombre',
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
                          ...filteredCategorias.map((categoria) {
                            return TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(categoria['nombre']!),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(categoria['descripcion']!),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: Icon(Icons.edit, color: Colors.black),
                                    onPressed: () => _editarCategoria(context, filteredCategorias.indexOf(categoria)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.black),
                                    onPressed: () => _eliminarCategoria(filteredCategorias.indexOf(categoria)),
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
        ],
      ),
    );
  }
}
