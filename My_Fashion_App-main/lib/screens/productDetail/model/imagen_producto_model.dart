class ImagenListModel {
  final int idImagen;
  final String imagenProducto;
  final Producto producto;

  ImagenListModel({
    required this.idImagen,
    required this.imagenProducto,
    required this.producto,
  });

  factory ImagenListModel.fromJson(Map<String, dynamic> json) =>
      ImagenListModel(
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
