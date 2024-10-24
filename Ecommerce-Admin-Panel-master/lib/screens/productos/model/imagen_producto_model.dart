import 'package:ecommerce_admin_panel/repository/repository_constants.dart';

class ImagenProductoModel {
  final int idImagen;
  final String imagenProducto;
  final Producto producto;

  ImagenProductoModel({
    required this.idImagen,
    required this.imagenProducto,
    required this.producto,
  });

  factory ImagenProductoModel.fromJson(Map<String, dynamic> json) =>
      ImagenProductoModel(
        idImagen: json["idImagen"],
        imagenProducto: json["imagenProducto"],
        producto: Producto.fromJson(json["producto"]),
      );
}

class Producto {
  final int idProducto;
  final String nombre;
  final String descripcion;
  final double precio;
  final Talla talla;
  final Color color;
  final int stock;
  final Proveedor proveedor;

  Producto({
    required this.idProducto,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.talla,
    required this.color,
    required this.stock,
    required this.proveedor,
  });

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        idProducto: json["idProducto"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        precio: json["precio"]?.toDouble(),
        talla: Talla.fromJson(json["talla"]),
        color: Color.fromJson(json["color"]),
        stock: json["stock"],
        proveedor: Proveedor.fromJson(json["proveedor"]),
      );
}

class Color {
  final int idColor;
  final String color;

  Color({
    required this.idColor,
    required this.color,
  });

  factory Color.fromJson(Map<String, dynamic> json) => Color(
        idColor: json["idColor"] ?? emptyString,
        color: json["color"] ?? emptyString,
      );
}

class Proveedor {
  final int idProveedor;
  final String nombre;
  final String direccion;
  final String telefono;
  final String correoElectronico;
  final String nit;

  Proveedor({
    required this.idProveedor,
    required this.nombre,
    required this.direccion,
    required this.telefono,
    required this.correoElectronico,
    required this.nit,
  });

  factory Proveedor.fromJson(Map<String, dynamic> json) => Proveedor(
        idProveedor: json["idProveedor"] ?? emptyString,
        nombre: json["nombre"] ?? emptyString,
        direccion: json["direccion"] ?? emptyString,
        telefono: json["telefono"] ?? emptyString,
        correoElectronico: json["correoElectronico"] ?? emptyString,
        nit: json["nit"] ?? emptyString,
      );
}

class Talla {
  final int idTalla;
  final String talla;

  Talla({
    required this.idTalla,
    required this.talla,
  });

  factory Talla.fromJson(Map<String, dynamic> json) => Talla(
        idTalla: json["idTalla"] ?? emptyString,
        talla: json["talla"] ?? emptyString,
      );
}
