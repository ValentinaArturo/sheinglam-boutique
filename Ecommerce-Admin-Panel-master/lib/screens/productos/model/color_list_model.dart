import 'package:ecommerce_admin_panel/repository/repository_constants.dart';

class ColorListModel {
  final int idColor;
  final String color;

  ColorListModel({
    required this.idColor,
    required this.color,
  });

  factory ColorListModel.fromJson(Map<String, dynamic> json) => ColorListModel(
        idColor: json["idColor"] ?? emptyString,
        color: json["color"] ?? emptyString,
      );
}
