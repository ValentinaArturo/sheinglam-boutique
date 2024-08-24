import 'package:flutter/material.dart';

class Unauthorized extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acceso Denegado'),
        backgroundColor: Colors.redAccent,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/fondo.jpg',
              // Ruta a tu imagen de fondo
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.5),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock, size: 120, color: Colors.redAccent),
                SizedBox(height: 20),
                Text(
                  'Acceso Denegado',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'No estás autorizado para acceder a esta aplicación.',
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // Navegar de regreso al login o hacer logout
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.redAccent,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'Volver al Inicio de Sesión',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
