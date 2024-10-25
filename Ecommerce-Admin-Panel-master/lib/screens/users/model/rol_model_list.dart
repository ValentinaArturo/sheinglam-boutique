class RolListmodel {
  final int idRol;
  final String nombre;

  RolListmodel({
    required this.idRol,
    required this.nombre,
  });

  factory RolListmodel.fromJson(Map<String, dynamic> json) => RolListmodel(
        idRol: json["idRol"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "idRol": idRol,
        "nombre": nombre,
      };
}
