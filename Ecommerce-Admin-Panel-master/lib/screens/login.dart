import 'dart:convert';

import 'package:ecommerce_admin_panel/auth/auth.dart';
import 'package:ecommerce_admin_panel/resources/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final response = await http.get(
      Uri.parse('${baseUrl}usuarios/login?email=$email&password=$password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final usuario = json.decode(response.body);

      // Suponiendo que la respuesta contiene un campo 'rol'
      String role = usuario['rol']['nombre'];

      if (role == 'Admin' || role == 'Vendor') {
        Provider.of<AuthProvider>(context, listen: false).login(role);
        Navigator.pushReplacementNamed(context, '/productos');
      } else {
        Navigator.pushReplacementNamed(context, '/no-autorizado');
      }
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email o contraseña incorrectos')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Error al iniciar sesión. Inténtalo de nuevo más tarde.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
