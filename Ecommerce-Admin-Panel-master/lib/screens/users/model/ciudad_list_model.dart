class CiudadListModel {
  final int idCiudad;
  final String nombre;

  CiudadListModel({
    required this.idCiudad,
    required this.nombre,
  });

  factory CiudadListModel.fromJson(Map<String, dynamic> json) =>
      CiudadListModel(
        idCiudad: json["idCiudad"],
        nombre: json["nombre"],
      );
}
