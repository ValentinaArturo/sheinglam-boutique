import 'package:ecommerce_admin_panel/common/bloc/base_state.dart';
import 'package:ecommerce_admin_panel/common/dialog/custom_state_dialog.dart';
import 'package:ecommerce_admin_panel/common/loader/loader.dart';
import 'package:ecommerce_admin_panel/common/menu_drawer.dart';
import 'package:ecommerce_admin_panel/screens/users/bloc/usuario_bloc.dart';
import 'package:ecommerce_admin_panel/screens/users/model/ciudad_list_model.dart';
import 'package:ecommerce_admin_panel/screens/users/model/cliente_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsuarioBloc(),
      child: const UsersScreen(),
    );
  }
}

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rolController = TextEditingController();

  List<CiudadListModel> ciudades = [];
  List<ClientListModel> usuarios = [];
  List<ClientListModel> filteredUsuarios = [];

  List<String> paises = [];
  List<String> roles = [];

  String selectedPais = '';
  String selectedCiudad = '';
  String selectedRol = '';

  bool _isLoading = false;
  late int? _idUsuario;

  @override
  void initState() {
    super.initState();
    _idUsuario = null;
    _loadInitialData();
    _loadUsuarios();
    _loadCiudades();
  }

  void _loadInitialData() async {}

  void _loadCiudades() async {
    context.read<UsuarioBloc>().add(
          CiudadShown(),
        );
  }

  void _loadUsuarios() async {
    context.read<UsuarioBloc>().add(
          UsuarioShown(),
        );
  }

  void _filterUsuarios(String query) {
    final results = usuarios.where((usuario) {
      final nombreLower = usuario.usuario.nombre.toLowerCase();
      final queryLower = query.toLowerCase();
      return nombreLower.contains(queryLower);
    }).toList();

    setState(() {
      filteredUsuarios = results;
    });
  }

  void _saveUsuario() {
    context.read<UsuarioBloc>().add(
          UsuarioSaved(
            nombre: nombreController.text,
            apellido: apellidoController.text,
            correoElectronico: correoController.text,
            password: passwordController.text,
            rol: int.parse(rolController.text),
          ),
        );
  }

  void _editUsuario() {
    context.read<UsuarioBloc>().add(
          UsuarioEdited(
            id: _idUsuario!,
            nombre: nombreController.text,
            apellido: apellidoController.text,
            correoElectronico: correoController.text,
            password: passwordController.text,
            rol: int.parse(rolController.text),
          ),
        );
  }

  void _deleteUsuario({required int id}) {
    context.read<UsuarioBloc>().add(
          UsuarioDeleted(id: id),
        );
  }

  void _createDireccionEnvio({required int id}) {
    context.read<UsuarioBloc>().add(
          DireccionEnvioSaved(
            idCliente: id,
            direccion: 'direccion',
            idCiudad: 0,
            codigoPostal: '0000',
            idPais: 1,
          ),
        );
  }

  void _updateDireccionEnvio({required int id}) {
    context.read<UsuarioBloc>().add(
          DireccionEnvioEdited(
            id: _idUsuario!,
            idCliente: id,
            direccion: 'direccion',
            idCiudad: 0,
            codigoPostal: '0000',
            idPais: 1,
          ),
        );
  }

  void _showEditModal([bool isEdit = false]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isEdit ? 'Editar Usuario' : 'Crear Usuario'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  controller: nombreController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Apellido'),
                  controller: apellidoController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Correo'),
                  controller: correoController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  controller: passwordController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Rol'),
                  controller: rolController,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                isEdit ? _editUsuario() : _saveUsuario();
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _showdeleteModal({required int id}) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar Usuario'),
          content: const Text(
            'Confirma que desas eliminar este usuario, todos los datos se perderán.',
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
                _deleteUsuario(id: id);
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      appBar: AppBar(
        title: const Text('Lista de Usuarios'),
        actions: [
          TextButton.icon(
            onPressed: () {
              // Lógica para agregar un nuevo usuario
              nombreController.clear();
              apellidoController.clear();
              correoController.clear();
              passwordController.clear();
              _showEditModal();
            },
            icon: const Icon(Icons.add, color: Colors.black),
            label: const Text(
              'Agregar',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: BlocListener<UsuarioBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (UsuarioInProgress):
              setState(() => _isLoading = true);
              break;
            case const (UsuarioSuccess):
              final loadedState = state as UsuarioSuccess;
              setState(() {
                _isLoading = false;
                usuarios = loadedState.usuarios;
                filteredUsuarios = loadedState.usuarios;
              });
              break;
            case const (UsuarioCreatedSuccess):
              _loadUsuarios();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Usuarios',
                description: "Usuario creado correctamente",
              );
              break;
            case const (UsuarioEditedSuccess):
              _loadUsuarios();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Usuarios',
                description: "Usuario editado correctamente",
              );
              break;
            case const (UsuarioDeletedSuccess):
              _loadUsuarios();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Usuarios',
                description: "Usuario borrado correctamente",
              );
              break;
            case const (CiudadSuccess):
              final loadedState = state as CiudadSuccess;
              setState(() {
                ciudades = loadedState.ciudades;
              });
              break;
            case const (DireccionEnvioCreatedSuccess):
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Direccion Envio',
                description: "Direccion de Envio creada correctamente",
              );
              break;
            case const (DireccionEnvioEditedSuccess):
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Direccion Envio',
                description: "Direccion de Envio editada correctamente",
              );
              break;
            case const (UsuarioError):
              final stateError = state as UsuarioError;
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Usuarios',
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
                        hintText: 'Buscar usuarios...',
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
                      onChanged: _filterUsuarios,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Table(
                        border: TableBorder.all(color: Colors.grey),
                        columnWidths: const {
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
                                  'Correo',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Contraseña',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Editar',
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
                          for (var usuario in filteredUsuarios)
                            TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(usuario.usuario.nombre),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      Text(usuario.usuario.correoElectronico),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(usuario.usuario.contrasea),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        setState(() {
                                          _idUsuario = usuario.idCliente;
                                          nombreController.text =
                                              usuario.usuario.nombre;
                                          correoController.text =
                                              usuario.usuario.correoElectronico;
                                          apellidoController.text =
                                              usuario.usuario.apellido;
                                          passwordController.text =
                                              usuario.usuario.contrasea;
                                          rolController.text =
                                              '${usuario.usuario.rol.idRol}';
                                        });
                                        _showEditModal(true);
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () =>
                                        _showdeleteModal(id: usuario.idCliente),
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
