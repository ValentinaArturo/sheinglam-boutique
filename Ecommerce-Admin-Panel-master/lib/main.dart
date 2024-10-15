import 'package:ecommerce_admin_panel/screens/categorias/categories.dart';
import 'package:ecommerce_admin_panel/screens/login/login.dart';
import 'package:ecommerce_admin_panel/screens/ordenes/orders.dart';
import 'package:ecommerce_admin_panel/screens/productos/products.dart';
import 'package:ecommerce_admin_panel/screens/returns.dart';
import 'package:ecommerce_admin_panel/screens/shipments.dart';
import 'package:ecommerce_admin_panel/screens/unathorized.dart';
import 'package:ecommerce_admin_panel/screens/users/users.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin SheinGlamBoutique',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFFFFD700), // Botones dorados
          textTheme: ButtonTextTheme.primary,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
          displayLarge: TextStyle(color: Colors.black),
          displayMedium: TextStyle(color: Colors.black),
          displaySmall: TextStyle(color: Colors.black),
          headlineMedium: TextStyle(color: Colors.black),
          headlineSmall: TextStyle(color: Colors.black),
          titleLarge: TextStyle(color: Colors.black),
          titleMedium: TextStyle(color: Colors.black),
          titleSmall: TextStyle(color: Colors.black),
          labelLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: const LoginPage(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/productos': (context) => ProductsScreen(),
        '/pedidos': (context) => const OrdersPage(),
        '/devoluciones': (context) => ReturnsScreen(),
        '/envios': (context) => ShipmentsScreen(),
        '/no-autorizado': (context) => Unauthorized(),
        '/usuarios': (context) => const UsersPage(),
        '/categorias': (context) => const CategoriaPage(),
      },
    );
  }
}
