import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.white,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.shopping_cart_outlined),
            label: 'Carrito',
            onTap: () => Navigator.pushNamed(context, '/cart'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.list_alt),
            label: 'Pedidos',
            onTap: () => Navigator.pushNamed(context, '/orders'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.person),
            label: 'Perfil',
            onTap: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Juan Pérez',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    'juan.perez@example.com',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                _buildProfileInfoRow(
                  icon: Icons.location_on,
                  label: 'Dirección:',
                  value: 'Calle Falsa 123',
                ),
                _buildProfileInfoRow(
                    icon: Icons.phone,
                    label: 'Teléfono:',
                    value: '+1 234 567 890'),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/returns');
                  },
                  icon: const Icon(
                    Icons.assignment_return,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Ver Devoluciones',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFAB9144),
                    // Color dorado para el botón
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30.0), // Bordes redondeados
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/edit_profile');
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Editar Perfil',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFAB9144),
                    // Color dorado para el botón
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30.0), // Bordes redondeados
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Implementar lógica para cerrar sesión
                    },
                    child: const Text(
                      'Cerrar Sesión',
                      style: TextStyle(color: Colors.red, fontSize: 16.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfoRow(
      {required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.black, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                ),
                Text(
                  value,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
