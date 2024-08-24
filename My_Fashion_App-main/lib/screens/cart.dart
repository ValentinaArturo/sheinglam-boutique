import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Map<String, dynamic>> cartItems = [
    {
      'name': 'Producto 1',
      'price': 100.0,
      'quantity': 1,
      'image': 'assets/images/product1.png'
    },
    {
      'name': 'Producto 2',
      'price': 150.0,
      'quantity': 2,
      'image': 'assets/images/product2.png'
    },
    {
      'name': 'Producto 3',
      'price': 200.0,
      'quantity': 1,
      'image': 'assets/images/product3.png'
    },
  ];

  final double shippingCost = 20.0; // Costo de envío fijo

  @override
  Widget build(BuildContext context) {
    double total = cartItems.fold(
            0.0, (sum, item) => sum + item['price'] * item['quantity']) +
        shippingCost;

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de Compras'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return Dismissible(
            key: Key(item['name']),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                cartItems.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('${item['name']} eliminado del carrito')),
              );
            },
            background: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 4,
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                leading: Image.asset(
                  item['image'],
                  width: 50,
                  height: 50,
                ),
                title: Text(
                  item['name'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Cantidad: ${item['quantity']}'),
                trailing: Text(
                  '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/payment');
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.payment),
                  SizedBox(width: 8),
                  Text('Pagar', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
