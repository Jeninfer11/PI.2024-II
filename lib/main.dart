import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy_file_gp2/injection.dart';
import 'package:shopy_file_gp2/src/presentation/pages/auth/register/bloc/RegisterPage.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/home/blocProviders.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/home/ClientHomePage.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/reserva/ReservaPage.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/servicio/bloc/ServicioPage.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/sobreNosotros/sobreNosotros.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencias();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: blocProviders,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          initialRoute: 'login',
          routes: {
            'login': (BuildContext context) => LoginPage(),
            'register': (BuildContext context) => RegisterPage(),
            'client/home': (BuildContext context) => ClientHomePage(),
            'client/reserva': (BuildContext context) => ReservaPage(),
            'home/sobrenosotros': (BuildContext context) => Sobrenosotros(),
            'home/servicio': (BuildContext context) => ServicioPage(),
          },
        ));
  }
}
