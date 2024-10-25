import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:ecommerce_admin_panel/common/bloc/base_state.dart';
import 'package:ecommerce_admin_panel/common/dialog/custom_state_dialog.dart';
import 'package:ecommerce_admin_panel/common/loader/loader.dart';
import 'package:ecommerce_admin_panel/common/menu_drawer.dart';
import 'package:ecommerce_admin_panel/screens/users/bloc/usuario_bloc.dart';
import 'package:ecommerce_admin_panel/screens/users/model/ciudad_list_model.dart';
import 'package:ecommerce_admin_panel/screens/users/model/cliente_list_model.dart';
import 'package:ecommerce_admin_panel/screens/users/model/direccion_list_model.dart';
import 'package:ecommerce_admin_panel/screens/users/model/rol_model_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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
  TextEditingController direccionController = TextEditingController();
  TextEditingController postalController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();

  List<CiudadListModel> ciudades = [];
  List<ClientListModel> usuarios = [];
  List<ClientListModel> filteredUsuarios = [];
  List<DireccionEnvioListModel> direccionesEnvio = [];

  List<String> paises = [];
  List<RolListmodel> roles = [];

  String selectedPais = '';
  CiudadListModel selectedCiudad = CiudadListModel(
    idCiudad: 0,
    nombre: '',
  );
  RolListmodel selectedRol = RolListmodel(
    idRol: 0,
    nombre: '',
  );

  bool _isLoading = false;
  late int? _idUsuario;
  late int? _idCliente;

  @override
  void initState() {
    super.initState();
    _idUsuario = null;
    _loadInitialData();
    _loadUsuarios();
    _loadCiudades();
    _loadRoles();
    _loadDirecciones();
  }

  void _loadInitialData() async {}

  void _loadCiudades() async {
    context.read<UsuarioBloc>().add(
          CiudadShown(),
        );
  }

  void _loadDirecciones() async {
    context.read<UsuarioBloc>().add(
          DireccionEncioShown(),
        );
  }

  void _loadUsuarios() async {
    context.read<UsuarioBloc>().add(
          UsuarioShown(),
        );
  }

  void _loadRoles() async {
    context.read<UsuarioBloc>().add(
          RolShown(),
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
            rol: selectedRol.idRol,
            postal: postalController.text,
            phone: telefonoController.text,
            address: direccionController.text,
            ciudad: selectedCiudad.idCiudad,
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
            rol: selectedRol.idRol,
            address: direccionController.text,
            ciudad: selectedCiudad.idCiudad,
            postal: postalController.text,
            phone: telefonoController.text,
          ),
        );
  }

  void _deleteUsuario({
    required int idUsuario,
    required int idCliente,
    required int idDireccionEnvio,
  }) {
    context.read<UsuarioBloc>().add(
          UsuarioDeleted(
            idUsuario: idUsuario,
            idCliente: idCliente,
            idDireccionEnvio: idDireccionEnvio,
          ),
        );
  }

  void _createDireccionEnvio({required int id}) {
    context.read<UsuarioBloc>().add(
          DireccionEnvioSaved(
            idCliente: id,
            direccion: direccionController.text,
            idCiudad: selectedCiudad.idCiudad,
            codigoPostal: postalController.text,
            idPais: 1,
          ),
        );
  }

  void _updateDireccionEnvio({required int id, required int idDireccionEnvio}) {
    context.read<UsuarioBloc>().add(
          DireccionEnvioEdited(
            id: idDireccionEnvio,
            idCliente: id,
            direccion: direccionController.text,
            idCiudad: selectedCiudad.idCiudad,
            codigoPostal: postalController.text,
            idPais: 1,
          ),
        );
  }

  void _showEditModal([bool isEdit = false]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
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
                  DropdownButtonFormField<RolListmodel>(
                    value: roles.firstWhere(
                        (rol) => rol.idRol == selectedRol?.idRol,
                        orElse: () => roles.first),
                    decoration: const InputDecoration(labelText: 'Rol'),
                    items: roles
                        .map((rol) => DropdownMenuItem<RolListmodel>(
                              value: rol,
                              child: Text(rol.nombre),
                            ))
                        .toList(),
                    onChanged: (RolListmodel? newValue) {
                      setState(() {
                        selectedRol = newValue!;
                      });
                    },
                  ),
                  DropdownButtonFormField<CiudadListModel>(
                    value: ciudades.firstWhere(
                      (ciudad) => ciudad.idCiudad == selectedCiudad?.idCiudad,
                      orElse: () => ciudades.first,
                    ),
                    decoration:
                        const InputDecoration(labelText: 'Departamento'),
                    items: ciudades
                        .map((ciudad) => DropdownMenuItem<CiudadListModel>(
                              value: ciudad,
                              child: Text(ciudad.nombre),
                            ))
                        .toList(),
                    onChanged: (CiudadListModel? newValue) {
                      setState(() {
                        selectedCiudad = newValue!;
                      });
                    },
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Direccion'),
                    controller: direccionController,
                  ),
                  TextField(
                    decoration:
                        const InputDecoration(labelText: 'Coidgo Postal'),
                    controller: postalController,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Telefono'),
                    controller: telefonoController,
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
        });
      },
    );
  }

  void _showdeleteModal({
    required int idUsuario,
    required int idCliente,
    required int idDireccionEnvio,
  }) async {
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
                _deleteUsuario(
                  idDireccionEnvio: idDireccionEnvio,
                  idCliente: idCliente,
                  idUsuario: idUsuario,
                );
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
              nombreController.clear();
              apellidoController.clear();
              correoController.clear();
              passwordController.clear();
              postalController.clear();
              direccionController.clear();
              telefonoController.clear();
              setState(() {
                selectedRol = roles.first;
                selectedCiudad = ciudades.first;
              });
              _showEditModal();
            },
            icon: const Icon(Icons.add, color: Colors.black),
            label: const Text(
              'Agregar',
              style: TextStyle(color: Colors.black),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              generatePdf(usuarios);
            },
            child: const Text('Generar Reporte'),
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
              final loadedState = state as UsuarioCreatedSuccess;
              _createDireccionEnvio(id: loadedState.user);
              _loadUsuarios();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Usuarios',
                description: "Usuario creado correctamente",
              );
              setState(() => _isLoading = false);
              break;
            case const (UsuarioEditedSuccess):
              setState(() => _isLoading = false);
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
                _isLoading = false;
              });
              break;
            case const (DireccionEnvioCreatedSuccess):
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Direccion Envio',
                description: "Direccion de Envio creada correctamente",
              );
              break;
            case const (DireccionEnvioEditedSuccess):
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Direccion Envio',
                description: "Direccion de Envio editada correctamente",
              );

              break;
            case const (RolSuccess):
              final loadedState = state as RolSuccess;
              setState(() {
                _isLoading = false;
                roles = loadedState.roles;
              });
              break;
            case const (DireccionEnvioSuccess):
              final loadedState = state as DireccionEnvioSuccess;
              setState(() {
                _isLoading = false;
                direccionesEnvio = loadedState.direcciones;
              });
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
                          2: FlexColumnWidth(4),
                          3: FixedColumnWidth(100),
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
                                  'Rol',
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
                            ],
                          ),
                          for (var usuario in filteredUsuarios)
                            TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      '${usuario.usuario.nombre} ${usuario.usuario.apellido}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      Text(usuario.usuario.correoElectronico),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(usuario.usuario.rol.nombre),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        setState(() {
                                          _idCliente = usuario.idCliente;
                                          _idUsuario =
                                              usuario.usuario.idUsuario;
                                          nombreController.text =
                                              usuario.usuario.nombre;
                                          correoController.text =
                                              usuario.usuario.correoElectronico;
                                          apellidoController.text =
                                              usuario.usuario.apellido;
                                          passwordController.text =
                                              usuario.usuario.contrasea;
                                          selectedRol = RolListmodel(
                                            idRol: usuario.usuario.rol.idRol,
                                            nombre: usuario.usuario.rol.nombre,
                                          );
                                          selectedCiudad = CiudadListModel(
                                            idCiudad:
                                                obtenerDireccionPorUsuario(
                                                        usuario.idCliente,
                                                        direccionesEnvio)!
                                                    .ciudad!
                                                    .idCiudad,
                                            nombre: obtenerDireccionPorUsuario(
                                                    usuario.idCliente,
                                                    direccionesEnvio)!
                                                .ciudad!
                                                .nombre,
                                          );
                                          postalController.text =
                                              obtenerDireccionPorUsuario(
                                                      usuario.idCliente,
                                                      direccionesEnvio)!
                                                  .codigoPostal;
                                          direccionController.text =
                                              obtenerDireccionPorUsuario(
                                                      usuario.idCliente,
                                                      direccionesEnvio)!
                                                  .direccion;
                                          telefonoController.text =
                                              obtenerDireccionPorUsuario(
                                                      usuario.idCliente,
                                                      direccionesEnvio)!
                                                  .cliente
                                                  .telefono!;
                                        });
                                        _showEditModal(true);
                                      }),
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

  DireccionEnvioListModel? obtenerDireccionPorUsuario(
      int idUsuario, List<DireccionEnvioListModel> direccionesEnvio) {
    return direccionesEnvio.firstWhere(
      (direccion) => direccion.cliente.idCliente == idUsuario,
      orElse: () => DireccionEnvioListModel(
        idDireccion: 0,
        cliente: Cliente(
          idCliente: 0,
          usuario: UsuarioD(
            idUsuario: 0,
            nombre: '',
            apellido: '',
            correoElectronico: '',
            contrasea: '',
            rol: RolD(
              idRol: 0,
              nombre: '',
            ),
          ),
          direccion: '',
          telefono: '',
        ),
        direccion: '',
        ciudad: Ciudad(
          idCiudad: 0,
          nombre: '',
        ),
        codigoPostal: '',
        pais: Pais(
          idPais: 0,
          nombre: '',
        ),
      ),
    );
  }

  void generatePdf(List<ClientListModel> clients) async {
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
            children: [
              pw.Text('Reporte de Clientes',
                  style: pw.TextStyle(fontSize: 24, font: font)),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  // Encabezados de la tabla
                  pw.TableRow(children: [
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('ID Cliente',
                            style: pw.TextStyle(font: font))),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child:
                            pw.Text('Nombre', style: pw.TextStyle(font: font))),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Apellido',
                            style: pw.TextStyle(font: font))),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Correo Electrónico',
                            style: pw.TextStyle(font: font))),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Dirección',
                            style: pw.TextStyle(font: font))),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Teléfono',
                            style: pw.TextStyle(font: font))),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Rol', style: pw.TextStyle(font: font))),
                  ]),
                  // Filas de datos
                  ...clients.map((client) {
                    return pw.TableRow(
                      children: [
                        pw.Text('${client.idCliente}',
                            style: pw.TextStyle(font: font)),
                        pw.Text('${client.usuario.nombre}',
                            style: pw.TextStyle(font: font)),
                        pw.Text('${client.usuario.apellido}',
                            style: pw.TextStyle(font: font)),
                        pw.Text('${client.usuario.correoElectronico}',
                            style: pw.TextStyle(font: font)),
                        pw.Text('${client.direccion}',
                            style: pw.TextStyle(font: font)),
                        pw.Text('${client.telefono}',
                            style: pw.TextStyle(font: font)),
                        pw.Text('${client.usuario.rol.nombre}',
                            style: pw.TextStyle(font: font)),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ],
          );
        },
      ),
    );

    // Guardar el archivo PDF
    Uint8List savedFile = await pdf.save();
    List<int> fileInts = List<int>.from(savedFile);
    html.AnchorElement(
      href: 'data:application/octet-stream;charset=utf-16le;base64,'
          '${base64.encode(fileInts)}',
    )
      ..setAttribute(
          'download', 'clientes-${DateTime.now().millisecondsSinceEpoch}.pdf')
      ..click();
  }
}
