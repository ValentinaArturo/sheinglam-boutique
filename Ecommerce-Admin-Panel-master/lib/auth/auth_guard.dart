import 'package:ecommerce_admin_panel/auth/auth.dart';
import 'package:ecommerce_admin_panel/screens/unathorized.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;

  AuthGuard({required this.child});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    if (auth.isAuthenticated &&
        (auth.role == 'Admin' || auth.role == 'Vendor')) {
      return child;
    } else {
      return Unathorized();
    }
  }
}
