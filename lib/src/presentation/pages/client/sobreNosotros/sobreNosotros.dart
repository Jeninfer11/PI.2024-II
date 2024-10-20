import 'package:flutter/material.dart';
import 'package:shopy_file_gp2/src/presentation/pages/auth/login/LoginPage.dart';
import 'package:url_launcher/url_launcher.dart';

class Sobrenosotros extends StatelessWidget {
  const Sobrenosotros({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre Nosotros'),
        backgroundColor: const Color.fromARGB(255, 225, 171, 99),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/img/Purma Wasi Tambo1.png'),
                      fit: BoxFit.cover)),
              child: Text(
                'Menu de opciones',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              iconColor: const Color.fromARGB(255, 230, 181, 125),
              title: Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              iconColor: const Color.fromARGB(255, 230, 181, 125),
              title: Text('Sobre Nosotros'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              iconColor: const Color.fromARGB(255, 230, 181, 125),
              title: Text('Cerrar Sesión'),
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
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/img/Purma Wasi Tambo1.png",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
            color: Colors.black54,
            colorBlendMode: BlendMode.darken,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.80,
            height: MediaQuery.of(context).size.height * 0.80,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 211, 157, 107),
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Divider(color: Colors.white),
                    const SizedBox(height: 10),

                    // Dirección con icono
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.white),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Dirección: Pasaje Suchiche, mz G, Lote 18 Urb. Villa Autonoma, Tarapoto, Perú",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Horario de atención con icono
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.white),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Horarios de Atención: Lun-Dom 8:00 AM - 10:00 PM",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Teléfono con icono
                    Row(
                      children: [
                        Icon(Icons.phone, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          "Teléfono: 952 466 796",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Síguenos en nuestras redes (al final)
                    Text(
                      "Síguenos en nuestras redes:",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.facebook, color: Colors.white),
                          onPressed: () async {
                            const url =
                                'https://www.facebook.com/your_page'; // Cambia esto por tu URL de Facebook
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'No se puede abrir $url';
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.tiktok, color: Colors.white),
                          onPressed: () async {
                            const url =
                                'https://www.tiktok.com/@hospedajetarapoto_peru?is_from_webapp=1&sender_device=pc';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'No se puede abrir $url';
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.camera_alt, color: Colors.white),
                          onPressed: () async {
                            const url =
                                'https://www.instagram.com/your_page'; // Cambia esto por tu URL de Instagram
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'No se puede abrir $url';
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
