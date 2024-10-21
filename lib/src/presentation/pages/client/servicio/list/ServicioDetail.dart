import 'package:flutter/material.dart';

// Clase que maneja los detalles de la reserva
class ServicioDetail {
  final String name;
  final String image;

  const ServicioDetail({
    required this.name,
    required this.image,
  });
}

// Clase que extiende StatelessWidget para mostrar los detalles de la reserva
class ServicioDetailScreen extends StatelessWidget {
  final ServicioDetail servicioDetail;
  final Map<String, String> product;

  const ServicioDetailScreen({
    Key? key,
    required this.servicioDetail,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles del servicio"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Mostrando los detalles de los servicios
          SizedBox(height: 20),
          Text(
            'Reserva: ${servicioDetail.name}',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          Image.network(
              servicioDetail.image), // Mostrando la imagen de la reserva

          SizedBox(height: 40),
        ],
      ),
    );
  }
}
