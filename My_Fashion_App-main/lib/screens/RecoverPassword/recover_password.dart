import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/common/dialog/custom_state_dialog.dart';
import 'package:my_fashion_app/common/loader/loader.dart';
import 'package:my_fashion_app/common/validate_password.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  bool iconOnFocus = true;

  bool _isLoading = false;
  int page = 1;

  void _sendPinViaEmail() {
    if (_formKey.currentState!.validate()) {
      context.read<RecoverBloc>().add(
            PinSent(
              email: _emailController.text,
            ),
          );
    }
  }

  void _validatePin() {
    if (_formKey.currentState!.validate()) {
      context.read<RecoverBloc>().add(
            PinValidated(
              email: _emailController.text,
              pin: _pinController.text,
            ),
          );
    }
  }

  void _updateUserPassword() {
    if (_formKey.currentState!.validate()) {
      context.read<RecoverBloc>().add(
            UserUpdatedPassword(
              email: _emailController.text,
              password: _passwordController.text,
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
            case RecoverPinSendSuccess:
              setState(() {
                _isLoading = false;
                page = 2;
              });
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Pin enviado',
                description:
                    'Se ha enviado un pin de recuperación a tu correo.',
              );
              break;
            case RecoverPinValidatedSuccess:
              setState(() {
                _isLoading = false;
                page = 3;
              });
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Pin validado',
                description: 'El pin se ha validado correctamente.',
              );
              break;
            case RecoverUserUpdatedSuccess:
              setState(() => _isLoading = false);
              Navigator.pop(context);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Usuario',
                description: 'Contraseña actualizada correctamente.',
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
            if (page == 1)
              Form(
                key: _formKey,
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset('assets/images/SG.jpg'),
                        // Imagen de logo o ilustración
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
                            _sendPinViaEmail();
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
                            'Enviar Pin de Recuperación',
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
            if (page == 2)
              Form(
                key: _formKey,
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset('assets/images/SG.jpg'),
                        // Imagen de logo o ilustración
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
                          'Introduce tu pin para validar',
                          style: TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _pinController,
                          validator: _inputValidator,
                          decoration: InputDecoration(
                            labelText: 'Pin',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            prefixIcon: const Icon(Icons.pin),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            _validatePin();
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
                            'Validar Pin de Recuperación',
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
            if (page == 3)
              Form(
                key: _formKey,
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset('assets/images/SG.jpg'),
                        // Imagen de logo o ilustración
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
                          'Introduce tu nueva contraseña.',
                          style: TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          validator: (text) {
                            if ((text == null || text.isEmpty)) {
                              return 'Campo requerido';
                            }

                            validatePassword(
                              text.trim(),
                              context,
                            );

                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Nueva contraseñ',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            prefixIcon: const Icon(Icons.password),
                            suffixIcon: Container(
                              margin: const EdgeInsets.only(
                                right: 15.0,
                              ),
                              child: GestureDetector(
                                child: !iconOnFocus
                                    ? const Icon(
                                        Icons.visibility_outlined,
                                        color: Colors.black,
                                        size: 20.0,
                                      )
                                    : const Icon(
                                        Icons.visibility_off_outlined,
                                        color: Colors.grey,
                                        size: 20.0,
                                      ),
                                onTap: () => setState(
                                  () => iconOnFocus = !iconOnFocus,
                                ),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: iconOnFocus,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            _updateUserPassword();
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
                            'Enviar nueva contraseña',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 20),
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
