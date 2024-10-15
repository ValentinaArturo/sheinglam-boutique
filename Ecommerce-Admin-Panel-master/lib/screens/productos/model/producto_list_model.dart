class ProductoListModel {
  final String titulo;
  final String descripcion;
  final String categoria;
  final String talla;

  ProductoListModel({
    required this.titulo,
    required this.descripcion,
    required this.categoria,
    required this.talla,
  });

  factory ProductoListModel.fromJson(Map<String, dynamic> json) =>
      ProductoListModel(
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        categoria: json["categoria"],
        talla: json["talla"],
      );
}
