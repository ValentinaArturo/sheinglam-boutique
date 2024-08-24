import 'package:flutter/material.dart';
import 'package:my_fashion_app/model/product.dart';
import 'package:my_fashion_app/screens/return_form.dart';
import 'package:my_fashion_app/screens/review_modal.dart';

class OrderDetailScreen extends StatelessWidget {
  final List<Product> productos;
  final double total;
  final String estado;

  OrderDetailScreen(
      {required this.productos, required this.total, required this.estado});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del Pedido'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Productos del Pedido',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: productos.length,
                itemBuilder: (context, index) {
                  final producto = productos[index];
                  return Card(
                    elevation: 10,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      leading: Image.asset(
                        producto.imagen,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(producto.nombre),
                      subtitle: Text('\$${producto.precio.toStringAsFixed(2)}'),
                      trailing: estado == 'Completado'
                          ? PopupMenuButton<String>(
                              elevation: 10,
                              onSelected: (value) {
                                if (value == 'Review') {
                                  showDialog(
                                    context: context,
                                    builder: (context) => ReviewModal(),
                                  );
                                } else if (value == 'Devolución') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReturnFormScreen(),
                                    ),
                                  );
                                }
                              },
                              itemBuilder: (BuildContext context) => [
                                PopupMenuItem(
                                  value: 'Review',
                                  child: Text('Review'),
                                ),
                                PopupMenuItem(
                                  value: 'Devolución',
                                  child: Text('Devolución'),
                                ),
                              ],
                              icon: Icon(Icons.more_vert),
                            )
                          : null,
                    ),
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
          ],
        ),
      ),
    );
  }
}
