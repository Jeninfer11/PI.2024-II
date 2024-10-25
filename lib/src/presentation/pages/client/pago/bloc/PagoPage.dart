import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopy_file_gp2/src/domain/models/AuthResponse.dart';
import 'package:shopy_file_gp2/src/domain/repository/AuthRepository.dart';
import 'package:shopy_file_gp2/src/domain/utils/Resource.dart';
import 'package:shopy_file_gp2/src/presentation/pages/auth/login/LoginPage.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/pago/bloc/PagoBloc.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/pago/bloc/PagoContent.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/pago/bloc/PagoState.dart';

class PagoPage extends StatefulWidget {
  const PagoPage({super.key});

  @override
  State<PagoPage> createState() => _PagoPageState();
}

class _PagoPageState extends State<PagoPage> {
  PagoBloc? _bloc;
  @override
  void initState() {
    // ejecuta una sola vez cuando carga la pantalla
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<PagoBloc>(context);

    return Scaffold(
      body: BlocListener<PagoBloc, PagoState>(
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
              msg: 'Pago exitoso',
              toastLength: Toast.LENGTH_LONG,
            );
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                'client/pago',
                (route) => false,
              );
            });
          }
        },
        child: BlocBuilder<PagoBloc, PagoState>(
          builder: (context, state) {
            final responseState = state.response;
            if (responseState is Loading) {
              return Stack(
                children: [
                  PagoContent(_bloc, state),
                  const Center(child: CircularProgressIndicator()),
                ],
              );
            }
            return PagoContent(_bloc, state);
          },
        ),
      ),
    );
  }
}
