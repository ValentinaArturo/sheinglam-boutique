class CategoriaPorductoListModel {
  final int idProductoCategoria;
  final ProductoC producto;
  final Categoria categoria;

  CategoriaPorductoListModel({
    required this.idProductoCategoria,
    required this.producto,
    required this.categoria,
  });

  factory CategoriaPorductoListModel.fromJson(Map<String, dynamic> json) =>
      CategoriaPorductoListModel(
        idProductoCategoria: json["idProductoCategoria"],
        producto: ProductoC.fromJson(json["producto"]),
        categoria: Categoria.fromJson(json["categoria"]),
      );
}

class Categoria {
  final int idCategoria;
  final String nombre;

  Categoria({
    required this.idCategoria,
    required this.nombre,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        idCategoria: json["idCategoria"],
        nombre: json["nombre"],
      );
}

class ProductoC {
  final int idProducto;

  ProductoC({
    required this.idProducto,
  });

  factory ProductoC.fromJson(Map<String, dynamic> json) => ProductoC(
        idProducto: json["idProducto"],
      );
}
