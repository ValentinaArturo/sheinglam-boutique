class LoginModel {
  final String token;
  final Usuario usuario;

  LoginModel({
    required this.token,
    required this.usuario,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        token: json["token"],
        usuario: Usuario.fromJson(json["usuario"]),
      );
}

class Usuario {
  final int idUsuario;
  final String nombre;
  final String apellido;
  final String correoElectronico;
  final String contrasea;
  final dynamic rol;

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
        rol: json["rol"],
      );
}
