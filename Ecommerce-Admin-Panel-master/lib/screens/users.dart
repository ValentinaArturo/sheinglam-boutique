import 'package:ecommerce_admin_panel/services/user_service.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final UserService _userService = UserService();

  List<Map<String, String>> usuarios = [];
  List<Map<String, String>> filteredUsuarios = [];
  List<String> paises = [];
  List<String> ciudades = [];
  List<String> roles = [];

  String selectedPais = '';
  String selectedCiudad = '';
  String selectedRol = '';

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _loadUsuarios();
  }

  void _loadInitialData() async {
    paises = await _userService.getPaises();
    roles = await _userService.getRoles();
    setState(() {});
  }

  void _loadCiudades(String pais) async {
    ciudades = await _userService.getCiudades(pais);
    setState(() {});
  }

  void _loadUsuarios() async {
    usuarios = await _userService.getUsuarios();
    filteredUsuarios = usuarios;
    setState(() {});
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
    String pais = usuario['pais']!;
    String ciudad = usuario['ciudad']!;
    String? direccion = usuario['direccion'];

    TextEditingController nombreController =
    TextEditingController(text: nombre);
    TextEditingController correoController =
    TextEditingController(text: correo);
    TextEditingController telefonoController =
    TextEditingController(text: telefono);
    TextEditingController direccionController =
    TextEditingController(text: direccion);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Usuario'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Nombre'),
                  controller: nombreController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Correo'),
                  controller: correoController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Teléfono'),
                  controller: telefonoController,
                ),
                DropdownButtonFormField<String>(
                  value: pais,
                  decoration: InputDecoration(labelText: 'País'),
                  items: paises.map((String pais) {
                    return DropdownMenuItem(
                      value: pais,
                      child: Text(pais),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedPais = value!;
                    _loadCiudades(selectedPais);
                  },
                ),
                DropdownButtonFormField<String>(
                  value: ciudad,
                  decoration: InputDecoration(labelText: 'Ciudad'),
                  items: ciudades.map((String ciudad) {
                    return DropdownMenuItem(
                      value: ciudad,
                      child: Text(ciudad),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedCiudad = value!;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: rol,
                  decoration: InputDecoration(labelText: 'Rol'),
                  items: roles.map((String rol) {
                    return DropdownMenuItem(
                      value: rol,
                      child: Text(rol),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedRol = value!;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Direccion'),
                  controller: direccionController,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Lógica para guardar los cambios del usuario en el servicio
                _saveUsuario({
                  'nombre': nombreController.text,
                  'correo': correoController.text,
                  'telefono': telefonoController.text,
                  'rol': selectedRol,
                  'pais': selectedPais,
                  'ciudad': selectedCiudad,
                  'direccion': direccionController.text,
                });
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

  void _saveUsuario(Map<String, String> usuario) async {
    await _userService.editarUsuario(0,usuario);
    _loadUsuarios(); // Recargar la lista de usuarios
  }

  void _deleteUsuario(Map<String, String> usuario) async {
    await _userService.eliminarUsuario(0);
    _loadUsuarios(); // Recargar la lista de usuarios
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
              _showEditModal({
                'nombre': '',
                'correo': '',
                'telefono': '',
                'rol': '',
                'pais': '',
                'ciudad': '',
                'direccion': '',
              });
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
                        for (var usuario in filteredUsuarios)
                          TableRow(
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
                                  icon: Icon(Icons.edit),
                                  onPressed: () => _showEditModal(usuario),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () => _deleteUsuario(usuario),
                                ),
                              ),
                            ],
                          ),
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