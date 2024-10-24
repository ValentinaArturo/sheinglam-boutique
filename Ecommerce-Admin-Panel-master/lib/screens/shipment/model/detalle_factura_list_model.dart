class DetalleFacturaListModel {
  final int? idDetalleFactura;
  final Factura? factura;
  final Producto? producto;
  final int? cantidad;
  final double? precioUnitario;
  final double? subtotal;

  DetalleFacturaListModel({
    this.idDetalleFactura,
    this.factura,
    this.producto,
    this.cantidad,
    this.precioUnitario,
    this.subtotal,
  });

  factory DetalleFacturaListModel.fromJson(Map<String, dynamic> json) =>
      DetalleFacturaListModel(
        idDetalleFactura: json["idDetalleFactura"],
        factura:
            json["factura"] == null ? null : Factura.fromJson(json["factura"]),
        producto: json["producto"] == null
            ? null
            : Producto.fromJson(json["producto"]),
        cantidad: json["cantidad"],
        precioUnitario: json["precioUnitario"]?.toDouble(),
        subtotal: json["subtotal"]?.toDouble(),
      );
}

class Factura {
  final int? idFactura;
  final Pedido? pedido;
  final double? total;
  final DateTime? fecha;

  Factura({
    this.idFactura,
    this.pedido,
    this.total,
    this.fecha,
  });

  factory Factura.fromJson(Map<String, dynamic> json) => Factura(
        idFactura: json["idFactura"],
        pedido: json["pedido"] == null ? null : Pedido.fromJson(json["pedido"]),
        total: json["total"]?.toDouble(),
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
      );
}

class Pedido {
  final int? idPedido;
  final Cliente? cliente;
  final DateTime? fecha;
  final double? total;
  final MetodoPago? metodoPago;
  final String? nit;

  Pedido({
    this.idPedido,
    this.cliente,
    this.fecha,
    this.total,
    this.metodoPago,
    this.nit,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
        idPedido: json["idPedido"],
        cliente:
            json["cliente"] == null ? null : Cliente.fromJson(json["cliente"]),
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
        total: json["total"]?.toDouble(),
        metodoPago: json["metodoPago"] == null
            ? null
            : MetodoPago.fromJson(json["metodoPago"]),
        nit: json["nit"],
      );
}

class Cliente {
  final int? idCliente;
  final Usuario? usuario;
  final String? direccion;
  final dynamic telefono;

  Cliente({
    this.idCliente,
    this.usuario,
    this.direccion,
    this.telefono,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        idCliente: json["idCliente"],
        usuario:
            json["usuario"] == null ? null : Usuario.fromJson(json["usuario"]),
        direccion: json["direccion"],
        telefono: json["telefono"],
      );
}

class Usuario {
  final int? idUsuario;
  final String? nombre;
  final String? apellido;
  final String? correoElectronico;
  final String? contrasea;
  final Rol? rol;

  Usuario({
    this.idUsuario,
    this.nombre,
    this.apellido,
    this.correoElectronico,
    this.contrasea,
    this.rol,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idUsuario: json["idUsuario"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        correoElectronico: json["correoElectronico"],
        contrasea: json["contraseña"],
        rol: json["rol"] == null ? null : Rol.fromJson(json["rol"]),
      );
}

class Rol {
  final int? idRol;
  final String? nombre;

  Rol({
    this.idRol,
    this.nombre,
  });

  factory Rol.fromJson(Map<String, dynamic> json) => Rol(
        idRol: json["idRol"],
        nombre: json["nombre"],
      );
}

class MetodoPago {
  final int? idMetodoPago;
  final String? nombre;

  MetodoPago({
    this.idMetodoPago,
    this.nombre,
  });

  factory MetodoPago.fromJson(Map<String, dynamic> json) => MetodoPago(
        idMetodoPago: json["idMetodoPago"],
        nombre: json["nombre"],
      );
}

class Producto {
  final int? idProducto;
  final String? nombre;
  final String? descripcion;
  final double? precio;
  final Talla? talla;
  final Color? color;
  final int? stock;
  final Proveedor? proveedor;

  Producto({
    this.idProducto,
    this.nombre,
    this.descripcion,
    this.precio,
    this.talla,
    this.color,
    this.stock,
    this.proveedor,
  });

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        idProducto: json["idProducto"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        precio: json["precio"]?.toDouble(),
        talla: json["talla"] == null ? null : Talla.fromJson(json["talla"]),
        color: json["color"] == null ? null : Color.fromJson(json["color"]),
        stock: json["stock"],
        proveedor: json["proveedor"] == null
            ? null
            : Proveedor.fromJson(json["proveedor"]),
      );
}

class Color {
  final int? idColor;
  final String? color;

  Color({
    this.idColor,
    this.color,
  });

  factory Color.fromJson(Map<String, dynamic> json) => Color(
        idColor: json["idColor"],
        color: json["color"],
      );
}

class Proveedor {
  final int? idProveedor;
  final String? nombre;
  final String? direccion;
  final String? telefono;
  final String? correoElectronico;
  final String? nit;

  Proveedor({
    this.idProveedor,
    this.nombre,
    this.direccion,
    this.telefono,
    this.correoElectronico,
    this.nit,
  });

  factory Proveedor.fromJson(Map<String, dynamic> json) => Proveedor(
        idProveedor: json["idProveedor"],
        nombre: json["nombre"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        correoElectronico: json["correoElectronico"],
        nit: json["nit"],
      );
}

class Talla {
  final int? idTalla;
  final String? talla;

  Talla({
    this.idTalla,
    this.talla,
  });

  factory Talla.fromJson(Map<String, dynamic> json) => Talla(
        idTalla: json["idTalla"],
        talla: json["talla"],
      );
}
