import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  // Simulación de datos de productos y tarifa de envío
  final List<Producto> productos = [
    Producto(nombre: 'Producto 1', imagen: 'assets/images/product1.png', precio: 29.99),
    Producto(nombre: 'Producto 2', imagen: 'assets/images/product2.png', precio: 39.99),
    Producto(nombre: 'Producto 3', imagen: 'assets/images/product3.png', precio: 49.99),
  ];
  final double tarifaEnvio = 5.99;

  @override
  Widget build(BuildContext context) {
    // Calcular el total de los productos
    double totalProductos = productos.fold(0, (sum, item) => sum + item.precio);
    double total = totalProductos + tarifaEnvio;

    return Scaffold(
      appBar: AppBar(
        title: Text('Resumen de Pago'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumen de Productos',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: productos.length,
                itemBuilder: (context, index) {
                  final producto = productos[index];
                  return ListTile(
                    leading: Image.asset(
                      producto.imagen,
                      width: 50,
                      height: 50,
                      fit: BoxFit.fitHeight,
                    ),
                    title: Text(producto.nombre),
                    trailing: Text('\$${producto.precio.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tarifa de Envío:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    '\$${tarifaEnvio.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Implementar la lógica de pago aquí
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  'Realizar Pago',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Clase Producto para representar un producto
class Producto {
  final String nombre;
  final String imagen;
  final double precio;

  Producto({required this.nombre, required this.imagen, required this.precio});
}
