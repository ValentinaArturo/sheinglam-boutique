class ImagenProductoModel {
  final int idImagen;
  final String imagenProducto;
  final ProductoI producto;

  ImagenProductoModel({
    required this.idImagen,
    required this.imagenProducto,
    required this.producto,
  });

  factory ImagenProductoModel.fromJson(Map<String, dynamic> json) =>
      ImagenProductoModel(
        idImagen: json["idImagen"],
        imagenProducto: json["imagenProducto"],
        producto: ProductoI.fromJson(json["producto"]),
      );
}

class ProductoI {
  final int idProducto;

  ProductoI({
    required this.idProducto,
  });

  factory ProductoI.fromJson(Map<String, dynamic> json) => ProductoI(
        idProducto: json["idProducto"],
      );
}
