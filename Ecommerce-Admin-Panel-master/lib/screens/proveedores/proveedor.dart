import 'package:ecommerce_admin_panel/common/bloc/base_state.dart';
import 'package:ecommerce_admin_panel/common/dialog/custom_state_dialog.dart';
import 'package:ecommerce_admin_panel/common/loader/loader.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/proveedor_list_model.dart';
import 'package:ecommerce_admin_panel/screens/proveedores/bloc/proveedor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProveedorPage extends StatelessWidget {
  const ProveedorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProveedorBloc(),
      child: const ProveedorBody(),
    );
  }
}

class ProveedorBody extends StatefulWidget {
  const ProveedorBody({super.key});

  @override
  State<ProveedorBody> createState() => _ProveedorBodyState();
}

class _ProveedorBodyState extends State<ProveedorBody> {
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _direccion = TextEditingController();
  final TextEditingController _telefono = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _nit = TextEditingController();

  List<ProveedorListModel> proveedores = [];

  bool _isLoading = false;
  late int? _idProveedor;

  @override
  void initState() {
    _idProveedor = null;
    _getProveedores();
    super.initState();
  }

  void _getProveedores() {
    context.read<ProveedorBloc>().add(
          ProveedorShown(),
        );
  }

  void _createProveedor() {
    context.read<ProveedorBloc>().add(
          ProveedorCreated(
            nombre: _nombre.text,
            direccion: _direccion.text,
            telefono: _telefono.text,
            email: _email.text,
            nit: _nit.text,
          ),
        );
  }

  void _editProveedor() {
    context.read<ProveedorBloc>().add(
          ProveedorEdited(
            id: _idProveedor!,
            nombre: _nombre.text,
            direccion: _direccion.text,
            telefono: _telefono.text,
            email: _email.text,
            nit: _nit.text,
          ),
        );
  }

  void _deleteProveedor() {
    context.read<ProveedorBloc>().add(
          ProveedorDeleted(
            id: _idProveedor!,
          ),
        );
  }

  void _filterProductos(String query) {
    final results = proveedores.where((producto) {
      final tituloLower = producto.nombre.toLowerCase();
      final queryLower = query.toLowerCase();
      return tituloLower.contains(queryLower);
    }).toList();

    setState(() {
      proveedores = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ProveedorBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (ProveedorInProgress):
              setState(() => _isLoading = true);
              break;
            case const (ProveedorListSuccess):
              final loadedState = state as ProveedorListSuccess;
              setState(() {
                _isLoading = false;
                proveedores = loadedState.proveedores;
              });
              break;
            case const (ProveedorCreatedSuccess):
              _getProveedores();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Proveedores',
                description: "Proveedor creada correctamente",
              );
              break;
            case const (ProveedorEditedSuccess):
              _getProveedores();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Proveedors',
                description: "Proveedor editada correctamente",
              );
              break;
            case const (ProveedorDeletedSuccess):
              _getProveedores();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Proveedors',
                description: "Proveedor borrada correctamente",
              );
              break;
            case const (ProveedorError):
              final stateError = state as ProveedorError;
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Proveedor',
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
            // TODO: agregar maqueta de la vista
            Container(),
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
