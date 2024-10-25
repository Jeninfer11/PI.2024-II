class Pago {
  int? id;
  String numero_tarjeta;
  String fecha_caducidad;
  String? codigo_seguridad;
  String nombre_titular;
  String? monto;

  Pago({
    this.id,
    required this.numero_tarjeta,
    required this.fecha_caducidad,
    required this.codigo_seguridad,
    required this.nombre_titular,
    this.monto,
  });

  factory Pago.fromJson(Map<String, dynamic> json) => Pago(
        id: json["id"] ?? 0,
        numero_tarjeta: json["numero_tarjeta"],
        fecha_caducidad: json["fecha_caducidad"],
        codigo_seguridad: json["codigo_seguridad"],
        nombre_titular: json["nombre_titular"],
        monto: json["monto"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "numero_tarjeta": numero_tarjeta,
        "fecha_caducidad": fecha_caducidad,
        "codigo_seguridad": codigo_seguridad,
        "nombre_titular": nombre_titular,
        "monto": monto,
      };
}
