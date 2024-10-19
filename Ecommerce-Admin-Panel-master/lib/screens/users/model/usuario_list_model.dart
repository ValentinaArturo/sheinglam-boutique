class UsuarioListModel {
  final int idUsuario;
  final String nombre;
  final String apellido;
  final String correoElectronico;
  final String contrasea;
  Rol? rol;

  UsuarioListModel({
    required this.idUsuario,
    required this.nombre,
    required this.apellido,
    required this.correoElectronico,
    required this.contrasea,
    this.rol,
  });

  factory UsuarioListModel.fromJson(Map<String, dynamic> json) =>
      UsuarioListModel(
        idUsuario: json["idUsuario"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        correoElectronico: json["correoElectronico"],
        contrasea: json["contraseña"],
        rol: json['rol'] != null ? Rol.fromJson(json["rol"]) : null,
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
