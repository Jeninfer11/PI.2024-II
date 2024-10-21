import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/home/bloc/ClientHomeBloc.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/home/bloc/ClientHomeState.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/reserva/ReservaPage.dart';

class ClientHomeServicioPage extends StatefulWidget {
  @override
  State<ClientHomeServicioPage> createState() => _ClientHomeServicioPageState();
}

class _ClientHomeServicioPageState extends State<ClientHomeServicioPage> {
  ClientHomeBloc? _bloc;

  // Datos de servicios
  List<Map<String, dynamic>> services = [
    {
      'name': 'TOURS',
      'image': 'assets/img/laguna.jpg',
    },
    {
      'name': 'TRANSPORTE DESDE EL AEROPUERTO',
      'image': 'assets/img/carro.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<ClientHomeBloc>(context);

   
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 222, 186),
      appBar: AppBar(
        title: const Text(
          'PurmaWuasi',
          style: TextStyle(
            color: Color.fromARGB(255, 243, 238, 229),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          
        ),
        backgroundColor: const Color.fromARGB(255, 210, 176, 131),
          leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white, // Estableciendo el color del ícono a blanco
          ),
          onPressed: () {
            Navigator.pop(context); // Volver a la pantalla principal
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      
      
      body: BlocBuilder<ClientHomeBloc, ClientHomeState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SERVICIOS',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF101010),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.35,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      final service = services[index];
                      return ServiceCard(
                        name: service['name']!,
                        image: service['image'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReservaPage(),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


// Card para servicios
class ServiceCard extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback onTap;

  const ServiceCard({
    required this.name,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(29, 230, 170, 79),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 15)),
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                image,
                width: 200,
                height: 105,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 20, 20, 20),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                   // Botón de elegir habitación
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: 200, // Cambia el ancho a un valor específico
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[700], // Color del botón
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // Navega a la ventana de la reserva
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ReservaPage()), // Asegúrate de que ReservaPage esté definida
                        );
                      },
                      child: Text(
                        'Elegir servicio',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white), // Letra en blanco
                      ),
                    ),
                  ),
                ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}