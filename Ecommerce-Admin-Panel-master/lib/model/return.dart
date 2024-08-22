class Return {
  int id;
  String motivo;
  String estado;
  DateTime fechaDevolucion;

  Return({
    required this.id,
    required this.motivo,
    required this.estado,
    required this.fechaDevolucion,
  });

  factory Return.fromJson(Map<String, dynamic> json) {
    return Return(
      id: json['id'],
      motivo: json['motivo'],
      estado: json['estado'],
      fechaDevolucion: DateTime.parse(json['fechaDevolucion']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'motivo': motivo,
      'estado': estado,
      'fechaDevolucion': fechaDevolucion.toIso8601String(),
    };
  }
}
