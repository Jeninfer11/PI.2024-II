import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:shopy_file_gp2/src/domain/models/AuthResponse.dart';
import 'package:shopy_file_gp2/src/domain/utils/Resource.dart';
import 'package:shopy_file_gp2/src/presentation/pages/auth/login/LoginContent.dart';
import 'package:shopy_file_gp2/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:shopy_file_gp2/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:shopy_file_gp2/src/presentation/pages/auth/login/bloc/LoginState.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/home/bloc/ClientHomeBloc.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/home/bloc/ClientHomeState.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/reserva/ReservaPage.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/sobreNosotros/sobreNosotros.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            final responseState = state.response;
            if (responseState is Error) {
              Fluttertoast.showToast(
                msg: responseState.message,
                toastLength: Toast.LENGTH_LONG,
              );
            } else if (responseState is Success) {
              final authResponse = responseState.data as AuthResponse;
              _bloc?.add(LoginSaveSession(authResponse: authResponse));
              Fluttertoast.showToast(
                msg: 'Login exitoso',
                toastLength: Toast.LENGTH_LONG,
              );
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  'client/home',
                  (route) => false,
                );
              });
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              final responseState = state.response;
              if (responseState is Loading) {
                return Stack(
                  children: [
                    LoginContent(_bloc, state),
                    Center(child: CircularProgressIndicator()),
                  ],
                );
              }
              return LoginContent(_bloc, state);
            },
          ),
        ),
      ),
    );
  }
}

class ClientHomePage extends StatefulWidget {
  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  ClientHomeBloc? _bloc;

  // Lista de productos simulada
  List<Map<String, dynamic>> products = [
    {
    'name': 'Habitaciones Dobles',
    'image': 'assets/img/indiv.png',
    'opcionSeleccionada': '1',
    'description': 'Capacidad máxima para 3 personas, cuenta con cómodas camas, baño privado, televisión y Wi-Fi gratuito.',
    'price' : 30.0, // Asegúrate de que sea un double
    'status': 'Disponible',
  },
  
  {
    'name': 'Habitaciones Triples',
    'image': 'assets/img/camatv.png',
    'opcionSeleccionada': '2',
    'description': 'Habitación especial para 4 personas, cuenta con cómodas camas, baño privado, televisión y Wi-Fi gratuito.',
    'price' : 60.0, // Asegúrate de que sea un double
    'status': 'Disponible',
  },

  {
    'name': 'Departamento',
    'image': 'assets/img/doble.png',
    'opcionSeleccionada': '3',
    'description': 'Departamentos amoblados, ideal para grupos de amigos o familias. Con cómodas camas, baño privado, televisión y Wi-Fi.', 
    'price' : 400.0, // Asegúrate de que sea un double
    'status': 'Disponible',
  },
  ];

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<ClientHomeBloc>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 200, 113),
      appBar: AppBar(
  title: const Text(
    'Hospedaje Purma Wasi',
    style: TextStyle(
      color: Color.fromARGB(255, 249, 248, 246), // Cambia el color del texto a marrón
    ),
  ),
  backgroundColor: const Color.fromARGB(255, 225, 171, 99),
  iconTheme: const IconThemeData(
    color: Colors.white, // Cambia el color de los íconos a blanco
  ),
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
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              iconColor: const Color.fromARGB(255, 230, 181, 125),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.house_siding_outlined),
              iconColor: const Color.fromARGB(255, 230, 181, 125),
              title: const Text('Reservas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReservaPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              iconColor: const Color.fromARGB(255, 230, 181, 125),
              title: const Text('Sobre Nosotros'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Sobrenosotros()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              iconColor: const Color.fromARGB(255, 230, 181, 125),
              title: const Text('Cerrar Sesion'),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'HABITACIONES',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 16, 16, 16),
                          ),
                        ),
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
                      childAspectRatio: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(
                        name: product['name']!,
                        image: product['image']!,
                        descripcion: product['description']!,
                        opcionSeleccionada: product['opcionSeleccionada']!,
                        price: product['price'],
                        status: product ['status']!,

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReservaDetailScreen(
                                name: product['name']!,
                                image: product['image']!,
                                descripcion: product['description']!,
                                opcionSeleccionada: product['opcionSeleccionada']!,
                                price: product['price'],// Pasar el precio
                                status: product['status']!, // Pasar el estado
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

// Nuevo Widget ReservaDetailScreen para mostrar los detalles de la reserva
class ReservaDetailScreen extends StatelessWidget {
  final String name;
  final String image;
  final String descripcion; // Añadir la descripción como parámetro
  final String opcionSeleccionada;
  final double price;
  final String status;

  const ReservaDetailScreen({
    required this.name,
    required this.image,
    required this.descripcion, // Recibir la descripción pasada
    required this.opcionSeleccionada,
    required this.price,
    required this.status,
  });

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Purma Wasi',
          style: TextStyle(color: const Color.fromARGB(255, 250, 250, 249)), // Estableciendo el color del texto a marrón
        ),
        backgroundColor: const Color.fromARGB(255, 225, 171, 99),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white, // Estableciendo el color del ícono a blanco
          ),
          onPressed: () {
            Navigator.pop(context); // Volver a la pantalla principal
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 241, 200, 113),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start, // Alineación a la izquierda
              children: [
                const SizedBox(height: 20),
                // Imagen
                Image.asset(image), // Mostrando la imagen de la reserva
                const SizedBox(height: 20),
                // Título del tipo de habitación
                Center(
                  child: Text(
                    name, // Usar el nombre pasado
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Descripción de la habitación
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    color: const Color.fromARGB(255, 241, 200, 113),
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      descripcion, // Mostrar la descripción pasada
                      style: TextStyle(fontSize: 16, color: Colors.brown[700]),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Mostrar el precio y el estado
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Estado de la habitación
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 233, 156, 41), // Color de fondo
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          status, // Mostrar el estado (Disponible o No disponible)
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                      // Precio de la habitación
                      Text(
                        's/. $price', // Mostrar el precio
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[800],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Botón de elegir habitación
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity, // Botón ancho completo
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
                          MaterialPageRoute(builder: (context) => ReservaPage()), // Asegúrate de que ReservaPage esté definida
                        );
                      },
                      child: Text(
                        'Elegir habitación',
                        style: TextStyle(fontSize: 18, color: Colors.white), // Letra en blanco
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String image;
  final String descripcion;
  final String opcionSeleccionada;
  final double price;
  final String status;
  final VoidCallback onTap;

  const ProductCard({
    required this.name,
    required this.image,
    required this.descripcion,
    required this.opcionSeleccionada,
    required this.price,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Navegación cuando se toca la imagen
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 248, 216, 147),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                image,
                width: 85,
                height: 85,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 20, 20, 20),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      descripcion, // Mostrar la descripción dinámica aquí
                      style: const TextStyle(
                        color: Color.fromARGB(255, 15, 15, 15),
                        fontSize: 14),
                      maxLines: 5, // Limitar las líneas si es necesario
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Estado de la habitación
                    Text(
                      status, // Mostrar el estado dinámico
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: status == 'Disponible' ? Colors.green : Colors.red, // Cambiar color según estado
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
