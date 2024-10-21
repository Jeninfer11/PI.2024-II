import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopy_file_gp2/src/domain/models/AuthResponse.dart';
import 'package:shopy_file_gp2/src/domain/repository/AuthRepository.dart';
import 'package:shopy_file_gp2/src/domain/utils/Resource.dart';
import 'package:shopy_file_gp2/src/presentation/pages/auth/login/LoginPage.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/reserva/ReservaPage.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/servicio/bloc/ServicioBloc.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/servicio/bloc/ServicioState.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/servicio/bloc/ServicioContent.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/sobreNosotros/sobreNosotros.dart';

class ServicioPage extends StatefulWidget {
  const ServicioPage({super.key});

  @override
  State<ServicioPage> createState() => _ServicioPageState();
}

class _ServicioPageState extends State<ServicioPage> {
  ServicioBloc? _bloc;
  @override
  void initState() {
    // ejecuta una sola vez cuando carga la pantalla
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<ServicioBloc>(context);

    return Scaffold(
      body: BlocListener<ServicioBloc, ServicioState>(
        listener: (context, state) {
          final responseState = state.response;
          if (responseState is Error) {
            Fluttertoast.showToast(
              msg: responseState.message,
              toastLength: Toast.LENGTH_LONG,
            );
          } else if (responseState is Success) {
            final authResponse = responseState.data as AuthResponse;
            Fluttertoast.showToast(
              msg: 'Servicio exitoso',
              toastLength: Toast.LENGTH_LONG,
            );
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                'client/servicio',
                (route) => false,
              );
            });
          }
        },
        child: BlocBuilder<ServicioBloc, ServicioState>(
          builder: (context, state) {
            final responseState = state.response;
            if (responseState is Loading) {
              return Stack(
                children: [
                  ServicioContent(_bloc, state),
                  const Center(child: CircularProgressIndicator()),
                ],
              );
            }
            return ServicioContent(_bloc, state);
          },
        ),
      ),
    );
  }
}
