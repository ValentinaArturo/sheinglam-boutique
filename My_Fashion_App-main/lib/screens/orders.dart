import 'package:flutter/material.dart';
import 'package:my_fashion_app/model/product.dart';
import 'package:my_fashion_app/screens/order_detail.dart';

class OrdersScreen extends StatelessWidget {
  // Simulación de productos en un pedido
  final List<Product> productosPedido = [
    Product(nombre: 'Producto 1', imagen: 'assets/images/product1.png', precio: 29.99),
    Product(nombre: 'Producto 2', imagen: 'assets/images/product2.png', precio: 39.99),
    Product(nombre: 'Producto 3', imagen: 'assets/images/product3.png', precio: 49.99),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Pedidos'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: 5, // Número de pedidos
        itemBuilder: (context, index) {
          // Simulación del estado del pedido
          String estado = index % 2 == 0 ? 'Completado' : 'En Proceso';

          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 4,
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              title: Text(
                'Pedido #$index',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    'Total: \$200',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Estado: $estado',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: estado == 'Completado' ?  Color(0xFFAB9144): Colors.orangeAccent,
                    ),
                  ),
                ],
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailScreen(
                      productos: productosPedido,
                      total: 200, // Total simulado
                      estado: estado,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}


