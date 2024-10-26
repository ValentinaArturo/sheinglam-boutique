class ProductoListModel {
  final int? idProducto;
  final String? nombre;
  final String? descripcion;
  final double? precio;
  final Talla? talla;
  final Color? color;
  final int? stock;
  final Proveedor? proveedor;

  ProductoListModel({
    this.idProducto,
    this.nombre,
    this.descripcion,
    this.precio,
    this.talla,
    this.color,
    this.stock,
    this.proveedor,
  });

  factory ProductoListModel.fromJson(Map<String, dynamic> json) =>
      ProductoListModel(
        idProducto: json["idProducto"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        precio: json["precio"]?.toDouble(),
        talla: json["talla"] == null ? null : Talla.fromJson(json["talla"]),
        color: json["color"] == null ? null : Color.fromJson(json["color"]),
        stock: json["stock"],
        proveedor: json["proveedor"] == null
            ? null
            : Proveedor.fromJson(json["proveedor"]),
      );
}

class Color {
  final int? idColor;
  final String? color;

  Color({
    this.idColor,
    this.color,
  });

  factory Color.fromJson(Map<String, dynamic> json) => Color(
        idColor: json["idColor"],
        color: json["color"],
      );
}

class Proveedor {
  final int? idProveedor;
  final String? nombre;
  final String? direccion;
  final String? telefono;
  final String? correoElectronico;
  final String? nit;

  Proveedor({
    this.idProveedor,
    this.nombre,
    this.direccion,
    this.telefono,
    this.correoElectronico,
    this.nit,
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
  final int? idTalla;
  final String? talla;

  Talla({
    this.idTalla,
    this.talla,
  });

  factory Talla.fromJson(Map<String, dynamic> json) => Talla(
        idTalla: json["idTalla"],
        talla: json["talla"],
      );
}
