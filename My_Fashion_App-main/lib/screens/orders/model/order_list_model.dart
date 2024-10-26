import 'dart:convert';

class OrderListModel {
  final int? idPedido;
  final Cliente? cliente;
  final DateTime? fecha;
  final double? total;
  final MetodoPago? metodoPago;
  final String? nit;

  OrderListModel({
    this.idPedido,
    this.cliente,
    this.fecha,
    this.total,
    this.metodoPago,
    this.nit,
  });

  factory OrderListModel.fromRawJson(String str) =>
      OrderListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
        idPedido: json["idPedido"],
        cliente:
            json["cliente"] == null ? null : Cliente.fromJson(json["cliente"]),
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
        total: json["total"]?.toDouble(),
        metodoPago: json["metodoPago"] == null
            ? null
            : MetodoPago.fromJson(json["metodoPago"]),
        nit: json["nit"],
      );

  Map<String, dynamic> toJson() => {
        "idPedido": idPedido,
        "cliente": cliente?.toJson(),
        "fecha": fecha?.toIso8601String(),
        "total": total,
        "metodoPago": metodoPago?.toJson(),
        "nit": nit,
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

class MetodoPago {
  final int? idMetodoPago;
  final String? nombre;

  MetodoPago({
    this.idMetodoPago,
    this.nombre,
  });

  factory MetodoPago.fromRawJson(String str) =>
      MetodoPago.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MetodoPago.fromJson(Map<String, dynamic> json) => MetodoPago(
        idMetodoPago: json["idMetodoPago"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "idMetodoPago": idMetodoPago,
        "nombre": nombre,
      };
}
