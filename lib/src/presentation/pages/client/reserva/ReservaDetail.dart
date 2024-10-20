import 'package:flutter/material.dart';

// Clase que maneja los detalles de la reserva
class ReservaDetail {
  final String name;
  final String image;

  const ReservaDetail({
    required this.name,
    required this.image,
  });
}

// Clase que extiende StatelessWidget para mostrar los detalles de la reserva
class ReservaDetailScreen extends StatelessWidget {
  final ReservaDetail reservaDetail;
  final Map<String, String> product;

  const ReservaDetailScreen({
    Key? key,
    required this.reservaDetail,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles de la Reserva"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Mostrando los detalles de la reserva
          SizedBox(height: 20),
          Text(
            'Reserva: ${reservaDetail.name}',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          Image.network(reservaDetail.image), // Mostrando la imagen de la reserva

          SizedBox(height: 40),

          // Mostrando el mapa de productos
          Text('Productos:', style: TextStyle(fontSize: 20)),
          Expanded(
            child: ListView.builder(
              itemCount: product.length,
              itemBuilder: (context, index) {
                String key = product.keys.elementAt(index);
                return ListTile(
                  title: Text(key),
                  subtitle: Text(product[key]!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}