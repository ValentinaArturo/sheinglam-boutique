class AddressListModel {
  final int? idDireccion;
  final Cliente? cliente;
  final String? direccion;
  final Ciudad? ciudad;
  final String? codigoPostal;
  final Pais? pais;

  AddressListModel({
    this.idDireccion,
    this.cliente,
    this.direccion,
    this.ciudad,
    this.codigoPostal,
    this.pais,
  });

  factory AddressListModel.fromJson(Map<String, dynamic> json) =>
      AddressListModel(
        idDireccion: json["idDireccion"],
        cliente:
            json["cliente"] == null ? null : Cliente.fromJson(json["cliente"]),
        direccion: json["direccion"],
        ciudad: json["ciudad"] == null ? null : Ciudad.fromJson(json["ciudad"]),
        codigoPostal: json["codigoPostal"],
        pais: json["pais"] == null ? null : Pais.fromJson(json["pais"]),
      );
}

class Ciudad {
  final int? idCiudad;
  final String? nombre;

  Ciudad({
    this.idCiudad,
    this.nombre,
  });

  factory Ciudad.fromJson(Map<String, dynamic> json) => Ciudad(
        idCiudad: json["idCiudad"],
        nombre: json["nombre"],
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

class Pais {
  final int? idPais;
  final String? nombre;

  Pais({
    this.idPais,
    this.nombre,
  });

  factory Pais.fromJson(Map<String, dynamic> json) => Pais(
        idPais: json["idPais"],
        nombre: json["nombre"],
      );
}
