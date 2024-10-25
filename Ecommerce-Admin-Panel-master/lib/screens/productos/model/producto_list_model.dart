class ProductoListModel {
  final int idProducto;
  final String nombre;
  final String descripcion;
  final double precio;
  final Talla talla;
  final ColorP color;
  final int stock;
  final Proveedor proveedor;

  ProductoListModel({
    required this.idProducto,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.talla,
    required this.color,
    required this.stock,
    required this.proveedor,
  });

  factory ProductoListModel.fromJson(Map<String, dynamic> json) =>
      ProductoListModel(
        idProducto: json["idProducto"] ?? 0,
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        precio: json["precio"]?.toDouble(),
        talla: Talla.fromJson(json["talla"]),
        color: ColorP.fromJson(json["color"]),
        stock: json["stock"],
        proveedor: Proveedor.fromJson(json["proveedor"]),
      );
}

class ColorP {
  final int idColor;
  final String color;

  ColorP({
    required this.idColor,
    required this.color,
  });

  factory ColorP.fromJson(Map<String, dynamic> json) => ColorP(
        idColor: json["idColor"],
        color: json["color"],
      );
}

class Proveedor {
  final int idProveedor;
  final String nombre;
  final dynamic direccion;
  final dynamic telefono;
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
        direccion: json["direccion"],
        telefono: json["telefono"],
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
