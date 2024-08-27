import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final List<Map<String, String>> usuarios = [
    {
      'nombre': 'Usuario 1',
      'correo': 'usuario1@example.com',
      'telefono': '123-456-7890',
      'rol': 'admin',
    },
    {
      'nombre': 'Usuario 2',
      'correo': 'usuario2@example.com',
      'telefono': '234-567-8901',
      'rol': 'user',
    },
    {
      'nombre': 'Usuario 3',
      'correo': 'usuario3@example.com',
      'telefono': '345-678-9012',
      'rol': 'user',
    },
  ];

  List<Map<String, String>> filteredUsuarios = [];

  @override
  void initState() {
    super.initState();
    filteredUsuarios = usuarios;
  }

  void _filterUsuarios(String query) {
    final results = usuarios.where((usuario) {
      final nombreLower = usuario['nombre']!.toLowerCase();
      final queryLower = query.toLowerCase();

      return nombreLower.contains(queryLower);
    }).toList();

    setState(() {
      filteredUsuarios = results;
    });
  }

  void _showEditModal(Map<String, String> usuario) {
    String nombre = usuario['nombre']!;
    String correo = usuario['correo']!;
    String telefono = usuario['telefono']!;
    String rol = usuario['rol']!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Usuario'),
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
                decoration: InputDecoration(labelText: 'Correo'),
                controller: TextEditingController(text: correo),
                onChanged: (value) {
                  correo = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Teléfono'),
                controller: TextEditingController(text: telefono),
                onChanged: (value) {
                  telefono = value;
                },
              ),
              if (rol == 'admin')
                DropdownButtonFormField<String>(
                  value: rol,
                  decoration: InputDecoration(labelText: 'Rol'),
                  items: [
                    DropdownMenuItem(
                      child: Text('Admin'),
                      value: 'admin',
                    ),
                    DropdownMenuItem(
                      child: Text('User'),
                      value: 'user',
                    ),
                  ],
                  onChanged: (value) {
                    rol = value!;
                  },
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Lógica para guardar cambios
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
        title: Text('Lista de Usuarios'),
        actions: [
          TextButton.icon(
            onPressed: () {
              // Lógica para agregar un nuevo usuario
            },
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
                      hintText: 'Buscar usuarios...',
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
                    onChanged: _filterUsuarios,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Table(
                      border: TableBorder.all(color: Colors.grey),
                      columnWidths: {
                        0: FlexColumnWidth(3),
                        1: FlexColumnWidth(4),
                        2: FlexColumnWidth(3),
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
                                'Correo',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Teléfono',
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
                        ...filteredUsuarios.map((usuario) {
                          return TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(usuario['nombre']!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(usuario['correo']!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(usuario['telefono']!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  icon: Icon(Icons.edit, color: Colors.black),
                                  onPressed: () {
                                    _showEditModal(usuario);
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.black),
                                  onPressed: () {
                                    // Lógica para eliminar el usuario
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
