import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/common/dialog/custom_state_dialog.dart';
import 'package:my_fashion_app/common/loader/loader.dart';
import 'package:my_fashion_app/screens/RecoverPassword/bloc/recover_bloc.dart';

class RecoverPasswordPage extends StatelessWidget {
  const RecoverPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RecoverBloc>(
      create: (context) => RecoverBloc(),
      child: const RecoverPasswordScreen(),
    );
  }
}

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({super.key});

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;

  void _handleRecoverEmail() {
    if (_formKey.currentState!.validate()) {
      context.read<RecoverBloc>().add(
            EmailRecovered(
              email: _emailController.text,
            ),
          );
    }
  }

  String? _inputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo requerido';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<RecoverBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case RecoverInProgress:
              setState(() => _isLoading = true);
              break;
            case RecoverEmailSuccess:
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Recuperacion exitosa',
                description:
                    'Se ha enviado un enlace de recuperación a tu correo.',
              );
              break;
            case RecoverError:
              final stateError = state as RecoverError;
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Recuperacion fallida',
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
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                          'assets/images/SG.jpg'), // Imagen de logo o ilustración
                      const SizedBox(height: 40),
                      const Text(
                        'Recuperar Contraseña',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Introduce tu correo electrónico para recibir un enlace de recuperación de contraseña.',
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        validator: _inputValidator,
                        decoration: InputDecoration(
                          labelText: 'Correo Electrónico',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          prefixIcon: const Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _handleRecoverEmail();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                              0xFFAB9144), // Color dorado para el botón
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30.0), // Bordes redondeados
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                        ),
                        child: const Text(
                          'Enviar Enlace de Recuperación',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Volver al Login',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: const Color(0xFFAB9144),
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
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
