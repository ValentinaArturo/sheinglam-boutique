import 'package:ecommerce_admin_panel/common/bloc/base_state.dart';
import 'package:ecommerce_admin_panel/common/dialog/custom_state_dialog.dart';
import 'package:ecommerce_admin_panel/common/loader/loader.dart';
import 'package:ecommerce_admin_panel/screens/promociones/bloc/promociones_bloc.dart';
import 'package:ecommerce_admin_panel/screens/promociones/model/promociones_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PromocionesPage extends StatelessWidget {
  const PromocionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PromocionesBloc(),
      child: const PromocionesBody(),
    );
  }
}

class PromocionesBody extends StatefulWidget {
  const PromocionesBody({super.key});

  @override
  State<PromocionesBody> createState() => _PromocionesBodyState();
}

class _PromocionesBodyState extends State<PromocionesBody> {
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _descripcion = TextEditingController();
  final TextEditingController _descuento = TextEditingController();

  List<PromocionListModel> promociones = [];

  bool _isLoading = false;
  late int? _idPromociones;

  @override
  void initState() {
    _idPromociones = null;
    _getPromocioneses();
    super.initState();
  }

  void _getPromocioneses() {
    context.read<PromocionesBloc>().add(
          PromocionesShown(),
        );
  }

  void _createPromociones() {
    context.read<PromocionesBloc>().add(
          PromocionesCreated(
            nombre: _nombre.text,
            descripcion: _descripcion.text,
            descuento: double.parse(_descuento.text),
          ),
        );
  }

  void _editPromociones() {
    context.read<PromocionesBloc>().add(
          PromocionesEdited(
            id: _idPromociones!,
            nombre: _nombre.text,
            descripcion: _descripcion.text,
            descuento: double.parse(_descuento.text),
          ),
        );
  }

  void _deletePromociones() {
    context.read<PromocionesBloc>().add(
          PromocionesDeleted(
            id: _idPromociones!,
          ),
        );
  }

  void _filterProductos(String query) {
    final results = promociones.where((producto) {
      final tituloLower = producto.nombre!.toLowerCase();
      final queryLower = query.toLowerCase();
      return tituloLower.contains(queryLower);
    }).toList();

    setState(() {
      promociones = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<PromocionesBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (PromocionesInProgress):
              setState(() => _isLoading = true);
              break;
            case const (PromocionesListSuccess):
              final loadedState = state as PromocionesListSuccess;
              setState(() {
                _isLoading = false;
                promociones = loadedState.promociones;
              });
              break;
            case const (PromocionesCreatedSuccess):
              _getPromocioneses();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Promocioneses',
                description: "Promociones creada correctamente",
              );
              break;
            case const (PromocionesEditedSuccess):
              _getPromocioneses();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Promocioness',
                description: "Promociones editada correctamente",
              );
              break;
            case const (PromocionesDeletedSuccess):
              _getPromocioneses();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Promocioness',
                description: "Promociones borrada correctamente",
              );
              break;
            case const (PromocionesError):
              final stateError = state as PromocionesError;
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Promociones',
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
