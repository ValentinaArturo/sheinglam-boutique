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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/fondo.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/SG.jpg',
                    height: 300,
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 500,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Correo',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0), // Bordes redondeados
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Color(0xFFFFD700)), // Color dorado cuando está enfocado
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 500,
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0), // Bordes redondeados
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Color(0xFFFFD700)), // Color dorado cuando está enfocado
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                      ),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 500,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, '/productos'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFAB9144), // Color dorado para el botón
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0), // Bordes redondeados
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                      ),
                      child: Text(
                        'Iniciar Sesión',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
