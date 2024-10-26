import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/common/dialog/custom_state_dialog.dart';
import 'package:my_fashion_app/common/loader/loader.dart';
import 'package:my_fashion_app/screens/returns/bloc/return_bloc.dart';
import 'package:my_fashion_app/screens/returns/model/return_list_model.dart';

class ReturnPage extends StatelessWidget {
  const ReturnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReturnBloc(),
      child: const ReturnsScreen(),
    );
  }
}

class ReturnsScreen extends StatefulWidget {
  const ReturnsScreen({super.key});

  @override
  State<ReturnsScreen> createState() => _ReturnsScreenState();
}

class _ReturnsScreenState extends State<ReturnsScreen> {
  List<ReturnListModel> returns = [];
  bool _isLoading = false;

  @override
  void initState() {
    _getReturnList();
    super.initState();
  }

  void _getReturnList() {
    context.read<ReturnBloc>().add(
          ReturnShown(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Devoluciones'),
        centerTitle: true,
      ),
      body: BlocListener<ReturnBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case ReturnInProgress:
              setState(() => _isLoading = true);
              break;
            case ReturnSuccess:
              final loadedState = state as ReturnSuccess;
              setState(() {
                _isLoading = false;
                returns = loadedState.devoluciones;
              });
              break;
            case ReturnError:
              final stateError = state as ReturnError;
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Devoluciones',
                description: stateError.message,
                isError: true,
              );
              break;
            case ServerClientError:
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
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: returns.length,
          itemBuilder: (context, index) {
            final returnItem = returns[index];
            if (_isLoading) {
              return const Loader();
            }
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 4,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(
                  'Devolución #${returnItem.idDevolucion}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                        'Monto: \$${returnItem.pedido!.total!.toStringAsFixed(2)}'),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text('Estado: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          returnItem.estado!,
                          style: TextStyle(
                            color: _getStatusColor(returnItem.estado!),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                onTap: () {
                  // Implementar la navegación a la pantalla de detalles de la devolución
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completado':
        return Colors.green;
      case 'Procesando':
        return Colors.orange;
      case 'Rechazado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
