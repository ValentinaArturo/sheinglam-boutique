import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del Producto'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  'assets/images/product1.png',
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Título del Producto',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Descripción del Producto',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Talla: M',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Color: Azul',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow, size: 28),
                  Icon(Icons.star, color: Colors.yellow, size: 28),
                  Icon(Icons.star, color: Colors.yellow, size: 28),
                  Icon(Icons.star, color: Colors.yellow, size: 28),
                  Icon(Icons.star_border, size: 28),
                  SizedBox(width: 8),
                  Text(
                    '4.0',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  // Implementar lógica para agregar al carrito
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                label: Text(
                  'Agregar al Carrito',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFAB9144),
                  // Color dorado para el botón
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // Bordes redondeados
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
