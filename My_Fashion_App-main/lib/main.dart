import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:my_fashion_app/screens/ar_view_screen.dart';
import 'package:my_fashion_app/screens/cart.dart';
import 'package:my_fashion_app/screens/edit_profile.dart';
import 'package:my_fashion_app/screens/login/login.dart';
import 'package:my_fashion_app/screens/orders.dart';
import 'package:my_fashion_app/screens/payment.dart';
import 'package:my_fashion_app/screens/productDetail/product_detail.dart';
import 'package:my_fashion_app/screens/productos/products.dart';
import 'package:my_fashion_app/screens/profile.dart';
import 'package:my_fashion_app/screens/RecoverPassword/recover_password.dart';
import 'package:my_fashion_app/screens/register/register.dart';
import 'package:my_fashion_app/screens/return_form.dart';
import 'package:my_fashion_app/screens/returns.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print(e.description);
  }
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
        popupMenuTheme: const PopupMenuThemeData(
          color: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        cardColor: Colors.white,
        dialogBackgroundColor: Colors.white,
        cardTheme: const CardTheme(
          surfaceTintColor: Colors.white,
          color: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[100],
          surfaceTintColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.white,
          textTheme: ButtonTextTheme.primary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
          ),
        ),
        listTileTheme: const ListTileThemeData(
          selectedTileColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(
              color: Color(0xFFAB9144) // Cambia a tu color preferido

              ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
                color: Color(0xFFAB9144) // Cambia a tu color preferido
                ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
                color: Color(0xFFAB9144) // Cambia a tu color preferido
                ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
                color: Color(0xFFAB9144) // Cambia a tu color preferido
                ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
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
        bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
      ),
      routes: {
        '/': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/recover': (context) => const RecoverPasswordScreen(),
        '/home': (context) => const HomePage(),
        '/product_detail': (context) => const ProductDetailPage(),
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
