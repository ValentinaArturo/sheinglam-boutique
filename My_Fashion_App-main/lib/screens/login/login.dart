import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/common/dialog/custom_state_dialog.dart';
import 'package:my_fashion_app/common/loader/loader.dart';
import 'package:my_fashion_app/screens/login/bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: const Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  late LoginBloc _loginBloc;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loginBloc = context.read<LoginBloc>();
  }

  void _handleLogin() {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      _loginBloc.add(
        LoginWithEmailPassword(
          codeEmail: _emailController.text.trim(),
          password: _passwordController.text,
          rememberEmail: true,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginBloc, BaseState>(
        listener: (BuildContext context, BaseState state) {
          switch (state.runtimeType) {
            case LoginInProgress:
              setState(() => _isLoading = true);
              break;
            case LoginSuccess:
              setState(() => _isLoading = false);
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case LoginError:
              final stateError = state as LoginError;
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Autenticación incorecta',
                description: stateError.error,
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
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset('assets/images/SG.jpg'),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Correo',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          prefixIcon: const Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo requerido';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          prefixIcon: const Icon(Icons.lock),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo requerido';
                          }
                          return null;
                        },
                        obscureText: true,
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () => _handleLogin(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFAB9144),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                        ),
                        child: const Text(
                          'Iniciar Sesión',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/recover');
                        },
                        child: Text(
                          'Recuperar Contraseña',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: const Color(0xFFAB9144),
                                  ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          'Registrarse',
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
            )
          ],
        ),
      ),
    );
  }
}
