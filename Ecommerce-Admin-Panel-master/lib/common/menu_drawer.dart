import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFAB9144),
            ),
            child: Text(
              'Menú de Navegación',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('Productos'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/productos');
            },
          ),
          ListTile(
            leading: Icon(Icons.receipt),
            title: Text('Pedidos'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/pedidos');
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment_return),
            title: Text('Devoluciones'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/devoluciones');
            },
          ),
          ListTile(
            leading: Icon(Icons.local_shipping),
            title: Text('Envíos'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/envios');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cerrar Sesión'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
