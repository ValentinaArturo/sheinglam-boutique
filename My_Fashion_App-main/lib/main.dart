import 'package:flutter/material.dart';
import 'package:my_fashion_app/screens/cart.dart';
import 'package:my_fashion_app/screens/edit_profile.dart';
import 'package:my_fashion_app/screens/login.dart';
import 'package:my_fashion_app/screens/orders.dart';
import 'package:my_fashion_app/screens/payment.dart';
import 'package:my_fashion_app/screens/product_detail.dart';
import 'package:my_fashion_app/screens/products.dart';
import 'package:my_fashion_app/screens/profile.dart';
import 'package:my_fashion_app/screens/recover_password.dart';
import 'package:my_fashion_app/screens/register.dart';
import 'package:my_fashion_app/screens/return_form.dart';
import 'package:my_fashion_app/screens/returns.dart';

void main() {
  runApp(ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.grey[100],
        popupMenuTheme: PopupMenuThemeData(
          color: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        cardColor: Colors.white,
        dialogBackgroundColor: Colors.white,
        cardTheme: CardTheme(
          surfaceTintColor: Colors.white,
          color: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[100],
          surfaceTintColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
          textTheme: ButtonTextTheme.primary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
          ),
        ),
        listTileTheme: ListTileThemeData(
          selectedTileColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle:
              TextStyle(color: Color(0xFFAB9144) // Cambia a tu color preferido

                  ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
                color: Color(0xFFAB9144) // Cambia a tu color preferido
                ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
                color: Color(0xFFAB9144) // Cambia a tu color preferido
                ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
                color: Color(0xFFAB9144) // Cambia a tu color preferido
                ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
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
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.white),
      ),
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/recover': (context) => RecoverPasswordScreen(),
        '/home': (context) => HomeScreen(),
        '/product_detail': (context) => ProductDetailScreen(),
        '/cart': (context) => CartScreen(),
        '/orders': (context) => OrdersScreen(),
        '/profile': (context) => ProfileScreen(),
        '/returns': (context) => ReturnsScreen(),
        '/return_form': (context) => ReturnFormScreen(),
        '/payment': (context) => PaymentScreen(),
        '/edit_profile': (context) => EditProfileScreen(),
      },
    );
  }
}
