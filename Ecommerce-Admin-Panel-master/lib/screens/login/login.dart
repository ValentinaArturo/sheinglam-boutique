import 'package:ecommerce_admin_panel/common/bloc/base_state.dart';
import 'package:ecommerce_admin_panel/common/dialog/custom_state_dialog.dart';
import 'package:ecommerce_admin_panel/common/loader/loader.dart';
import 'package:ecommerce_admin_panel/screens/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  bool iconOnFocus = true;

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

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, BaseState>(
      listener: (BuildContext context, BaseState state) {
        switch (state.runtimeType) {
          case const (LoginInProgress):
            setState(() => _isLoading = true);
            break;
          case const (LoginSuccess):
            setState(() => _isLoading = false);
            Navigator.pushReplacementNamed(context, '/productos');
            break;
          case const (LoginError):
            final stateError = state as LoginError;
            setState(() => _isLoading = false);
            CustomStateDialog.showAlertDialog(
              context,
              title: 'Autenticación incorecta',
              description: stateError.error,
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
              'assets/images/fondo.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Form(
            key: _loginFormKey,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/SG.jpg',
                      height: 300,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 500,
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Correo',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:
                                const BorderSide(color: Color(0xFFFFD700)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 500,
                      child: TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
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
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:
                                const BorderSide(color: Color(0xFFFFD700)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                        ),
                        obscureText: iconOnFocus,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 500,
                      child: ElevatedButton(
                        onPressed: () => _login(),
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
    );
  }

  void _login() {
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
}
