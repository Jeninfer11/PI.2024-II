// servicio.dart
class Servicio {
  int? id;
  String nombre; // Desayuno, Tour, Recogida
  String? image;
  String tipo_servicio;
  String lugarVisita; // Solo para el tour
  String hora; // Hora del servicio
  String numeroPersona;
  String? fechaInicio;
  String? fechaFin;
  // Cantidad de personas

  Servicio({
    this.id,
    required this.nombre,
    required this.image,
    required this.tipo_servicio,
    required this.lugarVisita,
    required this.hora,
    required this.numeroPersona,
    this.fechaInicio,
    this.fechaFin,
  });

  factory Servicio.fromJson(Map<String, dynamic> json) => Servicio(
        id: json["id"] ?? 0,
        nombre: json["nombre"],
        image: json["image"],
        tipo_servicio: json["tipo_servicio"],
        lugarVisita: json["lugarVisita"] ?? '',
        hora: json["hora"],
        numeroPersona: json["numeroPersona"],
        fechaInicio: json["fechaInicio"],
        fechaFin: json["fechaFin"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "image": image,
        "tipo_servicio": tipo_servicio,
        "lugarVisita": lugarVisita,
        "hora": hora,
        "numeroPersonas": numeroPersona,
        "fechaInicio": fechaInicio,
        "fechaFin": fechaFin,
      };
}
