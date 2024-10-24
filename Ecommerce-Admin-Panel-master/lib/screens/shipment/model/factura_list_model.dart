class FacturaListModel {
  final int? idFactura;
  final Pedido? pedido;
  final double? total;
  final DateTime? fecha;

  FacturaListModel({
    this.idFactura,
    this.pedido,
    this.total,
    this.fecha,
  });

  factory FacturaListModel.fromJson(Map<String, dynamic> json) =>
      FacturaListModel(
        idFactura: json["idFactura"],
        pedido: json["pedido"] == null ? null : Pedido.fromJson(json["pedido"]),
        total: json["total"]?.toDouble(),
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
      );
}

class Pedido {
  final int? idPedido;
  final Cliente? cliente;
  final DateTime? fecha;
  final double? total;
  final MetodoPago? metodoPago;
  final String? nit;

  Pedido({
    this.idPedido,
    this.cliente,
    this.fecha,
    this.total,
    this.metodoPago,
    this.nit,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
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

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        idCliente: json["idCliente"],
        usuario:
            json["usuario"] == null ? null : Usuario.fromJson(json["usuario"]),
        direccion: json["direccion"],
        telefono: json["telefono"],
      );
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

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idUsuario: json["idUsuario"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        correoElectronico: json["correoElectronico"],
        contrasea: json["contraseña"],
        rol: json["rol"] == null ? null : Rol.fromJson(json["rol"]),
      );
}

class Rol {
  final int? idRol;
  final String? nombre;

  Rol({
    this.idRol,
    this.nombre,
  });

  factory Rol.fromJson(Map<String, dynamic> json) => Rol(
        idRol: json["idRol"],
        nombre: json["nombre"],
      );
}

class MetodoPago {
  final int? idMetodoPago;
  final String? nombre;

  MetodoPago({
    this.idMetodoPago,
    this.nombre,
  });

  factory MetodoPago.fromJson(Map<String, dynamic> json) => MetodoPago(
        idMetodoPago: json["idMetodoPago"],
        nombre: json["nombre"],
      );
}
