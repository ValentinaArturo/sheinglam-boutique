class ProveedorListModel {
  final int? idProveedor;
  final String? nombre;
  final dynamic direccion;
  final dynamic telefono;
  final String? correoElectronico;
  final String? nit;

  ProveedorListModel({
    this.idProveedor,
    this.nombre,
    this.direccion,
    this.telefono,
    this.correoElectronico,
    this.nit,
  });

  factory ProveedorListModel.fromJson(Map<String, dynamic> json) =>
      ProveedorListModel(
        idProveedor: json["idProveedor"],
        nombre: json["nombre"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        correoElectronico: json["correoElectronico"],
        nit: json["nit"],
      );
}
