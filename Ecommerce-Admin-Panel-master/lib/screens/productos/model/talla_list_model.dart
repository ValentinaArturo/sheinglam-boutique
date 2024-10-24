import 'package:ecommerce_admin_panel/repository/repository_constants.dart';

class TallaListModel {
  final int idTalla;
  final String talla;

  TallaListModel({
    required this.idTalla,
    required this.talla,
  });

  factory TallaListModel.fromJson(Map<String, dynamic> json) => TallaListModel(
        idTalla: json["idTalla"] ?? emptyString,
        talla: json["talla"] ?? emptyString,
      );
}
