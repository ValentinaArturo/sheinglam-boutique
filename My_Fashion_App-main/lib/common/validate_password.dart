import 'package:flutter/material.dart';
import 'package:my_fashion_app/resources/constants.dart';

String? validatePassword(
    String value,
    BuildContext context,
    ) {
  final regex = RegExp(
    passwordRegExp,
  );
  if (!regex.hasMatch(value)) {
    return 'Contraseña debe tener al menos una mayúscula, una minúscula, un carácter especial, un número y al menos ser de 8 caracteres.';
  }
  return null;
}