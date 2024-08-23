import 'package:flutter/material.dart';

class Unathorized extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acceso Denegado'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock, size: 100, color: Colors.red),
            SizedBox(height: 20),
            Text(
              'No estás autorizado para acceder a esta aplicación.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar de regreso al login o hacer logout
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Volver al Inicio de Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
