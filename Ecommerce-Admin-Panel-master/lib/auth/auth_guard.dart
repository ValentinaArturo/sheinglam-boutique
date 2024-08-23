import 'package:ecommerce_admin_panel/auth/auth.dart';
import 'package:ecommerce_admin_panel/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;

  AuthGuard({required this.child});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    if (auth.isAuthenticated) {
      return child;
    } else {
      // Redirige a la pantalla de login si no está autenticado
      return LoginScreen();
    }
  }
}
