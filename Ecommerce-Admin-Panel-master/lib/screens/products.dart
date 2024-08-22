import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  final List<String> productos = ['Producto 1', 'Producto 2', 'Producto 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Productos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Lógica para agregar un nuevo producto
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: productos.length,
        itemBuilder: (context, index) {
          final producto = productos[index];
          return ListTile(
            title: Text(producto),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Lógica para editar el producto
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Lógica para eliminar el producto
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
