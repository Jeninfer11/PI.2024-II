class Reserva {
  int? id;
  String nombre;
  String apellido;
  String? identidad;
  String tipo_habitacion;
  String? fechaInicio;
  String? fechaFin;
  String? fechaReserva;

  Reserva({
    this.id,
    required this.nombre,
    required this.apellido,
    this.identidad,
    required this.tipo_habitacion,
    this.fechaInicio,
    this.fechaFin,
    this.fechaReserva,
  });

  factory Reserva.fromJson(Map<String, dynamic> json) => Reserva(
        id: json["id"] ?? 0,
        nombre: json["nombre"],
        apellido: json["apellido"],
        identidad: json["identidad"],
        tipo_habitacion: json["tipo_habitacion"],
        fechaInicio: json["fechaInicio"],
        fechaFin: json["fechaFin"] ?? '',
        fechaReserva: json["fechaReserva"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "identidad": identidad,
        "tipo_habitacion": tipo_habitacion,
        "fechaInicio": fechaInicio,
        "fechaFin": fechaFin,
        "fechaReserva": fechaReserva,
      };
}
