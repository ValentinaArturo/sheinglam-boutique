class PromocionListModel {
  final int? idPromocion;
  final String? nombre;
  final String? descripcion;
  final int? descuento;

  PromocionListModel({
    this.idPromocion,
    this.nombre,
    this.descripcion,
    this.descuento,
  });

  factory PromocionListModel.fromJson(Map<String, dynamic> json) =>
      PromocionListModel(
        idPromocion: json["idPromocion"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        descuento: json["descuento"],
      );
}
