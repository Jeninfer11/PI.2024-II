import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/reserva/ReservaPage.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/reserva/bloc/ReservaEvent.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/servicio/bloc/ServicioBloc.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/servicio/bloc/ServicioEvent.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/servicio/bloc/ServicioState.dart';
import 'package:shopy_file_gp2/src/presentation/utils/BlocFormItem.dart';
import 'package:shopy_file_gp2/src/presentation/widget/DefaultTextField.dart';

class ServicioContent extends StatelessWidget {
  final ServicioBloc? bloc;
  final ServicioState state;

  ServicioContent(this.bloc, this.state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Purma Wasi',
          style: TextStyle(color: Color.fromARGB(244, 109, 53, 53)),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 225, 171, 99),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context); // Volver a la pantalla principal
          },
        ),
      ),
      body: Form(
        key: state.formKey,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _imageBackground(context),
            Center(
              // Centrar el contenedor principal
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.80,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.3),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment
                        .center, // Centrar los hijos horizontalmente
                    children: [
                      const Text(
                        ' DESAYUNO',
                        style: TextStyle(
                          color: Color.fromARGB(244, 109, 53, 53),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center, // Centrando el texto
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Image.asset(
                          'assets/img/desayuno.jpg',
                          width: 250, // Ajusta el tamaño de la imagen
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      _numeroPersona(context),
                      _TextFieldFechaInicio(context),
                      _TextFieldFechaFin(context),
                      _TextFieldDiaServicio(context),
                      _buttonConfirmarServicio(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> services = [
    {
      'name': 'TOURS',
      'image': 'assets/img/laguna.jpg',
    },
  ];
  Widget _imageBackground(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: const Color.fromARGB(255, 241, 200, 113),
    );
  }

  Widget _numeroPersona(BuildContext context) {
    // Controlador de texto para mostrar el número de personas
    final TextEditingController _numberController = TextEditingController(
      text: state.numeroPersona.value,
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Muestra el número actual de personas
          Expanded(
            child: TextFormField(
              controller: _numberController,
              decoration: const InputDecoration(
                labelText: 'Número de Personas',
                labelStyle: TextStyle(
                    color: Colors.white, fontSize: 16), // Tamaño uniforme
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0), // Línea blanca hasta el borde
                ),
              ),
              style: const TextStyle(
                  color: Colors.white, fontSize: 16), // Tamaño y color uniforme
              readOnly: true, // Hacerlo solo lectura
            ),
          ),
          // Botón de decremento
          IconButton(
            icon: const Icon(Icons.remove, color: Colors.white),
            onPressed: () {
              int currentValue = int.tryParse(state.numeroPersona.value) ??
                  1; // Convertir a int
              // Verifica que el número de personas no sea menor a 1
              if (currentValue > 1) {
                BlocProvider.of<ServicioBloc>(context).add(
                  NumeroPersonaChanged(
                    numeroPersona:
                        BlocFormItem(value: (currentValue - 1).toString()),
                  ),
                );
              }
            },
          ),
          // Botón de incremento
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              int currentValue = int.tryParse(state.numeroPersona.value) ??
                  1; // Convertir a int
              BlocProvider.of<ServicioBloc>(context).add(
                NumeroPersonaChanged(
                  numeroPersona:
                      BlocFormItem(value: (currentValue + 1).toString()),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _TextFieldDiaServicio(BuildContext context) {
    final TextEditingController _dateController = TextEditingController(
      text: state.fechaInicio.value,
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: _dateController,
        decoration: const InputDecoration(
          labelText: 'Fecha dia de servicio',
          icon: Icon(Icons.date_range, color: Colors.white),
          labelStyle: TextStyle(color: Colors.white, fontSize: 16),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );

          if (pickedDate != null) {
            String formattedDate =
                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
            _dateController.text = formattedDate;
            bloc?.add(FechaInicioChanged(
                fechaInicio: BlocFormItem(value: formattedDate)));
          }
        },
      ),
    );
  }

  Widget _TextFieldFechaInicio(BuildContext context) {
    final TextEditingController _dateController = TextEditingController(
      text: state.fechaInicio.value,
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: _dateController,
        decoration: const InputDecoration(
          labelText: 'Fecha de Inicio',
          icon: Icon(Icons.date_range, color: Colors.white),
          labelStyle: TextStyle(color: Colors.white, fontSize: 16),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );

          if (pickedDate != null) {
            String formattedDate =
                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
            _dateController.text = formattedDate;
            bloc?.add(FechaInicioChanged(
                fechaInicio: BlocFormItem(value: formattedDate)));
          }
        },
      ),
    );
  }

  Widget _TextFieldFechaFin(BuildContext context) {
    final TextEditingController _dateController = TextEditingController(
      text: state.fechaFin.value,
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: _dateController,
        decoration: const InputDecoration(
          labelText: 'Fecha de Fin',
          icon: Icon(Icons.date_range, color: Colors.white),
          labelStyle: TextStyle(color: Colors.white, fontSize: 16),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Colors.orange,
                    onPrimary: Colors.white,
                    onSurface: Colors.black,
                  ),
                ),
                child: child!,
              );
            },
          );

          if (pickedDate != null) {
            DateTime fechaInicio =
                DateTime.tryParse(state.fechaInicio.value) ?? DateTime.now();

            if (pickedDate.isBefore(fechaInicio)) {
              Fluttertoast.showToast(
                msg:
                    'La fecha de fin no puede ser anterior a la fecha de inicio',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
              );
            } else {
              String formattedDate =
                  "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
              _dateController.text = formattedDate;
              // Aquí forzamos la actualización del Bloc y luego refrescamos el estado
              bloc?.add(FechaFinChanged(
                  fechaFin: BlocFormItem(value: formattedDate)));
            }
          }
        },
        validator: (value) {
          return state.fechaFin.error;
        },
      ),
    );
  }

  Widget _buttonConfirmarServicio(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: ElevatedButton(
        onPressed: () {
          if (state.formKey!.currentState!.validate()) {
            bloc?.add(ServicioSubmit());

            // Redirigir a ReservaPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReservaPage()),
            );
          } else {
            Fluttertoast.showToast(
              msg: 'Servicio no confirmado',
              toastLength: Toast.LENGTH_LONG,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3D2312),
        ),
        child: const Text(
          'Confirmar',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required Function(String) onChanged,
    required String? Function(String?) validator,
  }) {
    return DefaultTextField(
      label: label,
      icon: icon,
      onChange: onChanged,
      validator: validator,
    );
  }
}
