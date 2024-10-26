import 'dart:convert';

class RevisionListModel {
  final int? idRevision;
  final Cliente? cliente;
  final Producto? producto;
  final int? calificacion;
  final String? comentario;
  final DateTime? fecha;

  RevisionListModel({
    this.idRevision,
    this.cliente,
    this.producto,
    this.calificacion,
    this.comentario,
    this.fecha,
  });

  factory RevisionListModel.fromRawJson(String str) =>
      RevisionListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RevisionListModel.fromJson(Map<String, dynamic> json) =>
      RevisionListModel(
        idRevision: json["idRevision"],
        cliente:
            json["cliente"] == null ? null : Cliente.fromJson(json["cliente"]),
        producto: json["producto"] == null
            ? null
            : Producto.fromJson(json["producto"]),
        calificacion: json["calificacion"],
        comentario: json["comentario"],
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
      );

  Map<String, dynamic> toJson() => {
        "idRevision": idRevision,
        "cliente": cliente?.toJson(),
        "producto": producto?.toJson(),
        "calificacion": calificacion,
        "comentario": comentario,
        "fecha": fecha?.toIso8601String(),
      };
}

class Cliente {
  final int? idCliente;
  final Usuario? usuario;
  final String? direccion;
  final dynamic telefono;

  Cliente({
    this.idCliente,
    this.usuario,
    this.direccion,
    this.telefono,
  });

  factory Cliente.fromRawJson(String str) => Cliente.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        idCliente: json["idCliente"],
        usuario:
            json["usuario"] == null ? null : Usuario.fromJson(json["usuario"]),
        direccion: json["direccion"],
        telefono: json["telefono"],
      );

  Map<String, dynamic> toJson() => {
        "idCliente": idCliente,
        "usuario": usuario?.toJson(),
        "direccion": direccion,
        "telefono": telefono,
      };
}

class Usuario {
  final int? idUsuario;
  final String? nombre;
  final String? apellido;
  final String? correoElectronico;
  final String? contrasea;
  final Rol? rol;

  Usuario({
    this.idUsuario,
    this.nombre,
    this.apellido,
    this.correoElectronico,
    this.contrasea,
    this.rol,
  });

  factory Usuario.fromRawJson(String str) => Usuario.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idUsuario: json["idUsuario"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        correoElectronico: json["correoElectronico"],
        contrasea: json["contraseña"],
        rol: json["rol"] == null ? null : Rol.fromJson(json["rol"]),
      );

  Map<String, dynamic> toJson() => {
        "idUsuario": idUsuario,
        "nombre": nombre,
        "apellido": apellido,
        "correoElectronico": correoElectronico,
        "contraseña": contrasea,
        "rol": rol?.toJson(),
      };
}

class Rol {
  final int? idRol;
  final String? nombre;

  Rol({
    this.idRol,
    this.nombre,
  });

  factory Rol.fromRawJson(String str) => Rol.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rol.fromJson(Map<String, dynamic> json) => Rol(
        idRol: json["idRol"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "idRol": idRol,
        "nombre": nombre,
      };
}

class Producto {
  final int? idProducto;
  final String? nombre;
  final String? descripcion;
  final double? precio;
  final Talla? talla;
  final Color? color;
  final int? stock;
  final Proveedor? proveedor;

  Producto({
    this.idProducto,
    this.nombre,
    this.descripcion,
    this.precio,
    this.talla,
    this.color,
    this.stock,
    this.proveedor,
  });

  factory Producto.fromRawJson(String str) =>
      Producto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
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

  Map<String, dynamic> toJson() => {
        "idProducto": idProducto,
        "nombre": nombre,
        "descripcion": descripcion,
        "precio": precio,
        "talla": talla?.toJson(),
        "color": color?.toJson(),
        "stock": stock,
        "proveedor": proveedor?.toJson(),
      };
}

class Color {
  final int? idColor;
  final String? color;

  Color({
    this.idColor,
    this.color,
  });

  factory Color.fromRawJson(String str) => Color.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Color.fromJson(Map<String, dynamic> json) => Color(
        idColor: json["idColor"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "idColor": idColor,
        "color": color,
      };
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

  factory Proveedor.fromRawJson(String str) =>
      Proveedor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Proveedor.fromJson(Map<String, dynamic> json) => Proveedor(
        idProveedor: json["idProveedor"],
        nombre: json["nombre"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        correoElectronico: json["correoElectronico"],
        nit: json["nit"],
      );

  Map<String, dynamic> toJson() => {
        "idProveedor": idProveedor,
        "nombre": nombre,
        "direccion": direccion,
        "telefono": telefono,
        "correoElectronico": correoElectronico,
        "nit": nit,
      };
}

class Talla {
  final int? idTalla;
  final String? talla;

  Talla({
    this.idTalla,
    this.talla,
  });

  factory Talla.fromRawJson(String str) => Talla.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Talla.fromJson(Map<String, dynamic> json) => Talla(
        idTalla: json["idTalla"],
        talla: json["talla"],
      );

  Map<String, dynamic> toJson() => {
        "idTalla": idTalla,
        "talla": talla,
      };
}
