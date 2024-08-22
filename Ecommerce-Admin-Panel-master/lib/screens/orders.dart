import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  final List<String> pedidos = ['Pedido 1', 'Pedido 2', 'Pedido 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Pedidos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Lógica para agregar un nuevo pedido
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: pedidos.length,
        itemBuilder: (context, index) {
          final pedido = pedidos[index];
          return ListTile(
            title: Text(pedido),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Lógica para editar el pedido
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Lógica para eliminar el pedido
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
