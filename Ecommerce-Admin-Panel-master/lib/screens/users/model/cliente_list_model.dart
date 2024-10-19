import 'package:ecommerce_admin_panel/repository/repository_constants.dart';

class ClientListModel {
  final int idCliente;
  final Usuario usuario;
  final String direccion;
  final String telefono;

  ClientListModel({
    required this.idCliente,
    required this.usuario,
    required this.direccion,
    required this.telefono,
  });

  factory ClientListModel.fromJson(Map<String, dynamic> json) =>
      ClientListModel(
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
