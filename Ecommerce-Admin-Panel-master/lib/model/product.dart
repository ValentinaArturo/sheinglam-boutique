class Product {
  int id;
  String nombre;
  String descripcion;
  double precio;

  Product({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      precio: json['precio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
    };
  }
}
