import 'package:ecommerce_admin_panel/common/menu_drawer.dart';
import 'package:flutter/material.dart';

class ShipmentsScreen extends StatefulWidget {
  @override
  _ShipmentsScreenState createState() => _ShipmentsScreenState();
}

class _ShipmentsScreenState extends State<ShipmentsScreen> {
  final List<Map<String, dynamic>> envios = [
    {
      'nombre': 'Envío 1',
      'departamento': 'Guatemala',
      'precio': 50.0,
    },
    {
      'nombre': 'Envío 2',
      'departamento': 'Quetzaltenango',
      'precio': 75.0,
    },
    {
      'nombre': 'Envío 3',
      'departamento': 'Huehuetenango',
      'precio': 100.0,
    },
  ];

  late List<Map<String, dynamic>> filteredEnvios;

  @override
  void initState() {
    super.initState();
    filteredEnvios = envios;
  }

  void _agregarEnvio(BuildContext context) {
    // Lógica para agregar un nuevo envío
  }

  void _editarEnvio(BuildContext context, int index) {
    // Lógica para editar un envío existente
  }

  void _eliminarEnvio(int index) {
    setState(() {
      filteredEnvios.removeAt(index);
    });
  }

  void _filterEnvios(String query) {
    setState(() {
      filteredEnvios = envios.where((envio) {
        final nombreLower = envio['nombre'].toLowerCase();
        final departamentoLower = envio['departamento'].toLowerCase();
        final queryLower = query.toLowerCase();

        return nombreLower.contains(queryLower) || departamentoLower.contains(queryLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      appBar: AppBar(
        title: Text('Lista de Envíos'),
        actions: [
          TextButton.icon(
            onPressed: () => _agregarEnvio(context),
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
                      hintText: 'Buscar envíos...',
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
                    onChanged: _filterEnvios,
                  ),
                  SizedBox(height: 20),
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
                                  'Departamento',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Precio',
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
                          ...filteredEnvios.map((envio) {
                            return TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(envio['nombre']),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(envio['departamento']),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('\$${envio['precio']}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: Icon(Icons.edit, color: Colors.black),
                                    onPressed: () => _editarEnvio(context, filteredEnvios.indexOf(envio)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.black),
                                    onPressed: () => _eliminarEnvio(filteredEnvios.indexOf(envio)),
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
