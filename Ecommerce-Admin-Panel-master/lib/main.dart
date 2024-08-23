import 'package:ecommerce_admin_panel/auth/auth.dart';
import 'package:ecommerce_admin_panel/auth/auth_guard.dart';
import 'package:ecommerce_admin_panel/screens/login.dart';
import 'package:ecommerce_admin_panel/screens/orders.dart';
import 'package:ecommerce_admin_panel/screens/products.dart';
import 'package:ecommerce_admin_panel/screens/returns.dart';
import 'package:ecommerce_admin_panel/screens/shipments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin SheinGlamBoutique',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/productos': (context) => AuthGuard(child: ProductsScreen()),
        '/pedidos': (context) => AuthGuard(child: OrdersScreen()),
        '/devoluciones': (context) => AuthGuard(child: ReturnsScreen()),
        '/envios': (context) => AuthGuard(child: ShipmentsScreen()),
      },
    );
  }
}
