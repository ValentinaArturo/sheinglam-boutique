class CategoriaListModel {
  final int idCategoria;
  final String nombre;

  CategoriaListModel({
    required this.idCategoria,
    required this.nombre,
  });

  factory CategoriaListModel.fromJson(Map<String, dynamic> json) =>
      CategoriaListModel(
        idCategoria: json["idCategoria"],
        nombre: json["nombre"],
      );
}
