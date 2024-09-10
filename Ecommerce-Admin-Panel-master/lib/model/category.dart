class Category {
  final int id;
  final String nombre;

  Category({required this.id, required this.nombre});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['idCategoria'],
      nombre: json['nombre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCategoria': id,
      'nombre': nombre,
    };
  }
}