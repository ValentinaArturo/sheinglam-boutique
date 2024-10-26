class DireccionEnvioListModel {
  final int idDireccion;
  final Cliente cliente;
  final String direccion;
  final Ciudad? ciudad;
  final String codigoPostal;
  final Pais? pais;

  DireccionEnvioListModel({
    required this.idDireccion,
    required this.cliente,
    required this.direccion,
    required this.ciudad,
    required this.codigoPostal,
    required this.pais,
  });

  factory DireccionEnvioListModel.fromJson(Map<String, dynamic> json) =>
      DireccionEnvioListModel(
        idDireccion: json["idDireccion"],
        cliente: Cliente.fromJson(json["cliente"]),
        direccion: json["direccion"],
        ciudad: json["ciudad"] == null
            ? Ciudad(idCiudad: 0, nombre: '')
            : Ciudad.fromJson(json["ciudad"]),
        codigoPostal: json["codigoPostal"],
        pais: json["pais"] == null
            ? Pais(idPais: 0, nombre: '')
            : Pais.fromJson(json["pais"]),
      );

  Map<String, dynamic> toJson() => {
        "idDireccion": idDireccion,
        "cliente": cliente.toJson(),
        "direccion": direccion,
        "ciudad": ciudad!.toJson(),
        "codigoPostal": codigoPostal,
        "pais": pais!.toJson(),
      };
}

class Ciudad {
  final int idCiudad;
  final String nombre;

  Ciudad({
    required this.idCiudad,
    required this.nombre,
  });

  factory Ciudad.fromJson(Map<String, dynamic> json) => Ciudad(
        idCiudad: json["idCiudad"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "idCiudad": idCiudad,
        "nombre": nombre,
      };
}

class Cliente {
  final int idCliente;
  final UsuarioD usuario;
  final String direccion;
  final String? telefono;

  Cliente({
    required this.idCliente,
    required this.usuario,
    required this.direccion,
    required this.telefono,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        idCliente: json["idCliente"],
        usuario: UsuarioD.fromJson(json["usuario"]),
        direccion: json["direccion"],
        telefono: json["telefono"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "idCliente": idCliente,
        "usuario": usuario.toJson(),
        "direccion": direccion,
        "telefono": telefono,
      };
}

class UsuarioD {
  final int idUsuario;
  final String nombre;
  final String apellido;
  final String correoElectronico;
  final String contrasea;
  final RolD? rol;

  UsuarioD({
    required this.idUsuario,
    required this.nombre,
    required this.apellido,
    required this.correoElectronico,
    required this.contrasea,
    required this.rol,
  });

  factory UsuarioD.fromJson(Map<String, dynamic> json) => UsuarioD(
        idUsuario: json["idUsuario"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        correoElectronico: json["correoElectronico"],
        contrasea: json["contraseña"],
        rol: json["rol"] == null ? RolD(idRol: 0, nombre: ''): RolD.fromJson(json["rol"]),
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

class RolD {
  final int idRol;
  final String nombre;

  RolD({
    required this.idRol,
    required this.nombre,
  });

  factory RolD.fromJson(Map<String, dynamic> json) => RolD(
        idRol: json["idRol"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "idRol": idRol,
        "nombre": nombre,
      };
}

class Pais {
  final int idPais;
  final String nombre;

  Pais({
    required this.idPais,
    required this.nombre,
  });

  factory Pais.fromJson(Map<String, dynamic> json) => Pais(
        idPais: json["idPais"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "idPais": idPais,
        "nombre": nombre,
      };
}
