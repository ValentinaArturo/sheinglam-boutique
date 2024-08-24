import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:my_fashion_app/model/product.dart';

class HomeScreen extends StatelessWidget {
  final List<Product> productos = [
    Product(
        nombre: 'Producto 1',
        imagen: 'assets/images/product1.png',
        precio: 29.99),
    Product(
        nombre: 'Producto 2',
        imagen: 'assets/images/product2.png',
        precio: 39.99),
    Product(
        nombre: 'Producto 3',
        imagen: 'assets/images/product3.png',
        precio: 49.99),
    Product(
        nombre: 'Producto 4',
        imagen: 'assets/images/product4.png',
        precio: 59.99),
    Product(
        nombre: 'Producto 5',
        imagen: 'assets/images/product5.png',
        precio: 69.99),
    Product(
        nombre: 'Producto 6',
        imagen: 'assets/images/product1.png',
        precio: 79.99),
    Product(
        nombre: 'Producto 7',
        imagen: 'assets/images/product2.png',
        precio: 89.99),
    Product(
        nombre: 'Producto 8',
        imagen: 'assets/images/product3.png',
        precio: 99.99),
    Product(
        nombre: 'Producto 9',
        imagen: 'assets/images/product4.png',
        precio: 109.99),
    Product(
        nombre: 'Producto 10',
        imagen: 'assets/images/product5.png',
        precio: 119.99),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
        backgroundColor: Colors.white,
        toolbarHeight: 100,
        centerTitle: true,
        title: Image.asset(
          'assets/images/SG.jpg',
          height: 100,
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar productos...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onChanged: (value) {
                    // Implementar la lógica de búsqueda aquí
                  },
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: productos.length,
                    // Usar el número de productos en la lista
                    itemBuilder: (context, index) {
                      final producto = productos[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/product_detail');
                        },
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(15.0),
                                  ),
                                  child: Image.asset(
                                    producto.imagen,
                                    fit: BoxFit.fitHeight,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      producto.nombre,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '\$${producto.precio.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
