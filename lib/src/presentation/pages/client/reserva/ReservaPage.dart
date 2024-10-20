import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopy_file_gp2/src/domain/repository/AuthRepository.dart';
import 'package:shopy_file_gp2/src/domain/utils/Resource.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/reserva/ReservaContent.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/reserva/bloc/ReservaBloc.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/reserva/bloc/ReservaState.dart';

class ReservaPage extends StatefulWidget {
  const ReservaPage({super.key});

  @override
  State<ReservaPage> createState() => _ReservaPageState();
}

class _ReservaPageState extends State<ReservaPage> {
  ReservaBloc? _bloc;

  @override
  void initState() {
    // ejecuta una sola vez cuando carga la pantalla
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<ReservaBloc>(context);

    return Scaffold(
        body: Container(
      width: double.infinity,
      child: BlocListener<ReservaBloc, ReservaState>(
          listener: (context, state) {
        final responseState = state.response;
        if (responseState is Error) {
          Fluttertoast.showToast(
              msg: responseState.message, toastLength: Toast.LENGTH_LONG);
        } else if (responseState is Success) {
          final authResponse = responseState.data as AuthRepository;
          //_bloc?.add(LoginFormReset());
          //  _bloc?.add(LoginSaveUserSession(authResponse: authResponse));
          Fluttertoast.showToast(
              msg: 'Reserva exitosa', toastLength: Toast.LENGTH_LONG);
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pushNamedAndRemoveUntil(
                context,
                'client/reserva',
                (route) =>
                    false); //enviar a la pagina de roles, despues de guardar el usuario
          });
        }
      }, child:
              BlocBuilder<ReservaBloc, ReservaState>(builder: (context, state) {
        final responseState = state.response;
        if (responseState is Loading) {
          return Stack(
            children: [
              ReservaContent(_bloc, state),
              Center(child: CircularProgressIndicator())
            ],
          );
        }
        return ReservaContent(_bloc, state);
      })),
    ));
  }
}
