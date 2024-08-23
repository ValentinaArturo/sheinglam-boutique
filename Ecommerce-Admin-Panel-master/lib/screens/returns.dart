import 'package:ecommerce_admin_panel/common/menu_drawer.dart';
import 'package:flutter/material.dart';

class ReturnsScreen extends StatelessWidget {
  final List<String> devoluciones = ['Devolución 1', 'Devolución 2', 'Devolución 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      appBar: AppBar(
        title: Text('Lista de Devoluciones'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Lógica para agregar una nueva devolución
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: devoluciones.length,
        itemBuilder: (context, index) {
          final devolucion = devoluciones[index];
          return ListTile(
            title: Text(devolucion),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Lógica para editar la devolución
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Lógica para eliminar la devolución
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
