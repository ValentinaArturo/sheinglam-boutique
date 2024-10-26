import 'package:flutter/material.dart';

String? validatePassword(
    String value,
    BuildContext context,
    ) {
  final regex = RegExp(
    passwordRegex,
  );
  if (!regex.hasMatch(value)) {
    return 'Contraseña debe tener al menos una mayúscula, una minúscula, un carácter especial, un número y al menos ser de 8 caracteres.';
  }
  return null;
}