import 'package:ecommerce_admin_panel/repository/repository_constants.dart';

class OrdenListModel {
  final int idPedidoEstado;
  final Pedido pedido;
  final EstadoPedido estadoPedido;
  final String fecha;

  OrdenListModel({
    required this.idPedidoEstado,
    required this.pedido,
    required this.estadoPedido,
    required this.fecha,
  });

  factory OrdenListModel.fromJson(Map<String, dynamic> json) => OrdenListModel(
        idPedidoEstado: json["idPedidoEstado"],
        pedido: Pedido.fromJson(json["pedido"]),
        estadoPedido: EstadoPedido.fromJson(json["estadoPedido"]),
        fecha: json["fecha"],
      );
}

class EstadoPedido {
  final int idEstadoPedido;
  final String nombre;

  EstadoPedido({
    required this.idEstadoPedido,
    required this.nombre,
  });

  factory EstadoPedido.fromJson(Map<String, dynamic> json) => EstadoPedido(
        idEstadoPedido: json["idEstadoPedido"],
        nombre: json["nombre"],
      );
}

class Pedido {
  final int idPedido;
  final Cliente cliente;
  final String fecha;
  final double total;
  final MetodoPago metodoPago;
  final String nit;

  Pedido({
    required this.idPedido,
    required this.cliente,
    required this.fecha,
    required this.total,
    required this.metodoPago,
    required this.nit,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
        idPedido: json["idPedido"],
        cliente: Cliente.fromJson(json["cliente"]),
        fecha: json["fecha"],
        total: json["total"]?.toDouble(),
        metodoPago: MetodoPago.fromJson(json["metodoPago"]),
        nit: json["nit"],
      );
}

class Cliente {
  final int idCliente;
  final Usuario usuario;
  final String direccion;
  final String telefono;

  Cliente({
    required this.idCliente,
    required this.usuario,
    required this.direccion,
    required this.telefono,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        idCliente: json["idCliente"],
        usuario: Usuario.fromJson(json["usuario"]),
        direccion: json["direccion"],
        telefono: json["telefono"] ?? emptyString,
      );
}

class Usuario {
  final int idUsuario;
  final String nombre;
  final String apellido;
  final String correoElectronico;
  final String contrasea;
  final Rol rol;

  Usuario({
    required this.idUsuario,
    required this.nombre,
    required this.apellido,
    required this.correoElectronico,
    required this.contrasea,
    required this.rol,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idUsuario: json["idUsuario"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        correoElectronico: json["correoElectronico"],
        contrasea: json["contraseña"],
        rol: Rol.fromJson(json["rol"]),
      );
}

class Rol {
  final int idRol;
  final String nombre;

  Rol({
    required this.idRol,
    required this.nombre,
  });

  factory Rol.fromJson(Map<String, dynamic> json) => Rol(
        idRol: json["idRol"],
        nombre: json["nombre"],
      );
}

class MetodoPago {
  final int idMetodoPago;
  final String nombre;

  MetodoPago({
    required this.idMetodoPago,
    required this.nombre,
  });

  factory MetodoPago.fromJson(Map<String, dynamic> json) => MetodoPago(
        idMetodoPago: json["idMetodoPago"],
        nombre: json["nombre"],
      );
}
