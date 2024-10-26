import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/common/dialog/custom_state_dialog.dart';
import 'package:my_fashion_app/common/loader/loader.dart';
import 'package:my_fashion_app/screens/register/bloc/register_bloc.dart';
import 'package:my_fashion_app/screens/register/model/address_model.dart';
import 'package:my_fashion_app/screens/register/model/cliente_model.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(),
      child: const Scaffold(
        body: RegisterScreen(),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  List<ClienteListModel> clientes = [];
  List<AddressListModel> direccionesEnvio = [];

  bool _isLoading = false;

  @override
  void initState() {
    _getInitialLists();
    super.initState();
  }

  void _getInitialLists() {
    context.read<RegisterBloc>()
      ..add(
        ClientListShown(),
      )
      ..add(
        DireccionListShown(),
      );
  }

  void _handleRegisterUser() {
    if (_formKey.currentState!.validate()) {
      if (_confirmPassController.text != _passwordController.text) {
        CustomStateDialog.showAlertDialog(
          context,
          title: 'Advertencia',
          description: 'Las contraseñas no coinciden',
        );
      } else {
        context.read<RegisterBloc>().add(
              RegisterNewUser(
                name: _nameController.text,
                lastName: _lastNameController.text,
                email: _emailController.text,
                password: _passwordController.text,
                idRol: 1,
              ),
            );
      }
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
      body: BlocListener<RegisterBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case RegisterInProgress:
              setState(() => _isLoading = true);
              break;
            case RegisterClientListSuccess:
              final loadedState = state as RegisterClientListSuccess;
              setState(() {
                _isLoading = false;
                clientes = loadedState.clientes;
              });
              break;
            case RegisterAddressListSuccess:
              final loadedState = state as RegisterAddressListSuccess;
              setState(() {
                _isLoading = false;
                direccionesEnvio = loadedState.direcciones;
              });
              break;
            case RegisterUserSuccess:
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Registro exitoso',
                description: 'Usuario creado correctamente',
              );
              break;
            case RegisterError:
              final stateError = state as RegisterError;
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Registro fallido',
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
                      Image.asset('assets/images/SG.jpg'),
                      const SizedBox(height: 40),
                      const Text(
                        'Crear una Cuenta',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _nameController,
                        validator: _inputValidator,
                        decoration: InputDecoration(
                          labelText: 'Nombre',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          prefixIcon: const Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _lastNameController,
                        validator: _inputValidator,
                        decoration: InputDecoration(
                          labelText: 'Apellido',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          prefixIcon: const Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        validator: _inputValidator,
                        decoration: InputDecoration(
                          labelText: 'Correo',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          prefixIcon: const Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        validator: _inputValidator,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          prefixIcon: const Icon(Icons.lock),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _confirmPassController,
                        validator: _inputValidator,
                        decoration: InputDecoration(
                          labelText: 'Confirmar Contraseña',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          prefixIcon: const Icon(Icons.lock),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () => _handleRegisterUser(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFAB9144),
                          // Color dorado para el botón
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30.0), // Bordes redondeados
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                        ),
                        child: const Text(
                          'Registrarse',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Ya tienes una cuenta? Inicia sesión',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: const Color(0xFFAB9144),
                                  ),
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
