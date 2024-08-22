class Order {
  int id;
  double total;
  DateTime fecha;

  Order({
    required this.id,
    required this.total,
    required this.fecha,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      total: json['total'],
      fecha: DateTime.parse(json['fecha']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total': total,
      'fecha': fecha.toIso8601String(),
    };
  }
}
