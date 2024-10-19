import 'package:my_fashion_app/resources/constants.dart';

class ProductoListModel {
  final int idProductoCategoria;
  final Producto producto;
  final Categoria categoria;

  ProductoListModel({
    required this.idProductoCategoria,
    required this.producto,
    required this.categoria,
  });

  factory ProductoListModel.fromJson(Map<String, dynamic> json) =>
      ProductoListModel(
        idProductoCategoria: json["idProductoCategoria"],
        producto: Producto.fromJson(json["producto"]),
        categoria: Categoria.fromJson(json["categoria"]),
      );
}

class Categoria {
  final int idCategoria;
  final String nombre;

  Categoria({
    required this.idCategoria,
    required this.nombre,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        idCategoria: json["idCategoria"],
        nombre: json["nombre"],
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
        idColor: json["idColor"],
        color: json["color"],
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
        idProveedor: json["idProveedor"],
        nombre: json["nombre"],
        direccion: json["direccion"] ?? emptyString,
        telefono: json["telefono"] ?? emptyString,
        correoElectronico: json["correoElectronico"],
        nit: json["nit"],
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
        idTalla: json["idTalla"],
        talla: json["talla"],
      );
}
