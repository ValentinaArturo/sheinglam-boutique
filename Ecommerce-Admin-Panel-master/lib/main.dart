import 'package:ecommerce_admin_panel/screens/login.dart';
import 'package:ecommerce_admin_panel/screens/orders.dart';
import 'package:ecommerce_admin_panel/screens/products.dart';
import 'package:ecommerce_admin_panel/screens/returns.dart';
import 'package:ecommerce_admin_panel/screens/shipments.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tienda Web',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/productos': (context) => ProductsScreen(),
        '/pedidos': (context) => OrdersScreen(),
        '/devoluciones': (context) => ReturnsScreen(),
        '/envios': (context) => ShipmentsScreen(),
      },
    );
  }
}
