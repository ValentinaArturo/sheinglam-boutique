import 'package:ecommerce_admin_panel/auth/auth.dart';
import 'package:ecommerce_admin_panel/auth/auth_guard.dart';
import 'package:ecommerce_admin_panel/screens/categories.dart';
import 'package:ecommerce_admin_panel/screens/login.dart';
import 'package:ecommerce_admin_panel/screens/orders.dart';
import 'package:ecommerce_admin_panel/screens/products.dart';
import 'package:ecommerce_admin_panel/screens/returns.dart';
import 'package:ecommerce_admin_panel/screens/shipments.dart';
import 'package:ecommerce_admin_panel/screens/unathorized.dart';
import 'package:ecommerce_admin_panel/screens/users.dart';
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
        scaffoldBackgroundColor: Colors.white,
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFFFFD700), // Botones dorados
          textTheme: ButtonTextTheme.primary,
        ),
        textTheme: TextTheme(
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
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/productos': (context) => AuthGuard(child: ProductsScreen()),
        '/pedidos': (context) => AuthGuard(child: OrdersScreen()),
        '/devoluciones': (context) => AuthGuard(child: ReturnsScreen()),
        '/envios': (context) => AuthGuard(child: ShipmentsScreen()),
        '/no-autorizado': (context) => Unauthorized(),
        '/usuarios': (context) => UsersScreen(),
        '/categorias': (context) => CategoriesScreen(),
      },
    );
  }
}
