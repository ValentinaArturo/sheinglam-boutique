import 'package:ecommerce_admin_panel/repository/repository_constants.dart';

class ProveedorListModel {
  final int idProveedor;
  final String nombre;
  final String direccion;
  final String telefono;
  final String correoElectronico;
  final String nit;

  ProveedorListModel({
    required this.idProveedor,
    required this.nombre,
    required this.direccion,
    required this.telefono,
    required this.correoElectronico,
    required this.nit,
  });

  factory ProveedorListModel.fromJson(Map<String, dynamic> json) =>
      ProveedorListModel(
        idProveedor: json["idProveedor"] ?? emptyString,
        nombre: json["nombre"] ?? emptyString,
        direccion: json["direccion"] ?? emptyString,
        telefono: json["telefono"] ?? emptyString,
        correoElectronico: json["correoElectronico"] ?? emptyString,
        nit: json["nit"] ?? emptyString,
      );
}
