import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/home/ClientHomePage.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/home/bloc/ClientHomeBloc.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/home/bloc/ClientHomeState.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/reserva/ReservaPage.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/sobreNosotros/sobreNosotros.dart';

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
      'description':
          'Servicio para conocer los mejores lugares turísticos de Tarapoto.',
      'price': 100.0,
    },
    {
      'name': 'TRANSPORTE DESDE EL AEROPUERTO',
      'image': 'assets/img/carro.jpg',
      'description': 'Recogida desde el aeropuerto.',
      'price': 20.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<ClientHomeBloc>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 222, 186),
      appBar: AppBar(
        title: const Text(
          'Hospedaje Purma Wasi',
          style: TextStyle(
            color: Color.fromARGB(255, 243, 238, 229),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 210, 176, 131),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/Purma Wasi Tambo1.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Text(
                'Menu de opciones',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              iconColor: const Color(0xFFE6B57D),
              title: const Text(
                'Inicio',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.house_siding_outlined),
              iconColor: const Color(0xFFE6B57D),
              title: const Text(
                'Reservas',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReservaPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              iconColor: const Color(0xFFE6B57D),
              title: const Text(
                'Sobre Nosotros',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Sobrenosotros()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              iconColor: const Color(0xFFE6B57D),
              title: const Text(
                'Cerrar Sesion',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
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
                      crossAxisCount: 1, // Mostrar una tarjeta por fila
                      childAspectRatio: 1.35, // Hacer la tarjeta más alta
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      final service = services[index];
                      return ServiceCard(
                        name: service['name']!,
                        image: service['image']!,
                        description: service['description']!,
                        price: service['price'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServiceDetailScreen(
                                name: service['name']!,
                                image: service['image']!,
                                description: service['description']!,
                                price: service['price'],
                              ),
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
  final String description;
  final double price;
  final VoidCallback onTap;

  const ServiceCard({
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Navegación cuando se toca la imagen
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(29, 227, 189, 132),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            // Espacio extra antes de la imagen con Padding
            const Padding(
                padding: EdgeInsets.only(
                    top: 15)), // Ajusta el valor según tu necesidad

            // Imagen centrada en la parte superior
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                image,
                width: 190, // Cambia este valor según tu necesidad
                height: 95, // Altura fija para la imagen
                fit: BoxFit.cover,
              ),
            ),
            // Padding para el texto
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .center, // Centramos los elementos en el eje horizontal
                children: [
                  // Nombre del servicio
                  Text(
                    name,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 20, 20, 20),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Descripción del servicio
                  Text(
                    description, // Mostrar la descripción dinámica aquí
                    style: const TextStyle(
                        color: Color.fromARGB(255, 15, 15, 15), fontSize: 14),
                    maxLines: 5, // Limitar las líneas si es necesario
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Precio del servicio
                  Text(
                    'Precio: s/. $price', // Mostrar el precio dinámico aquí
                    style: const TextStyle(
                      fontSize: 16, // Aumenta el tamaño de la fuente aquí
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 15, 15, 15),
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

// Pantalla de detalle del servicio
class ServiceDetailScreen extends StatelessWidget {
  final String name;
  final String image;
  final String description;
  final double price;

  const ServiceDetailScreen({
    required this.name,
    required this.image,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: const Color.fromARGB(255, 239, 214, 182),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(image, height: 240, fit: BoxFit.cover),
            const SizedBox(height: 20),
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Text(
              'Precio: s/. $price',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
