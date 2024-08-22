import 'package:flutter/material.dart';

class ShipmentsScreen extends StatelessWidget {
  final List<String> envios = ['Envío 1', 'Envío 2', 'Envío 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Envíos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Lógica para agregar un nuevo envío
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: envios.length,
        itemBuilder: (context, index) {
          final envio = envios[index];
          return ListTile(
            title: Text(envio),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Lógica para editar el envío
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Lógica para eliminar el envío
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
