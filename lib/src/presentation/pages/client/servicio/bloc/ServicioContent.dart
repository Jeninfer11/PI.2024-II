import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
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
                        'SOLICITAR SERVICIO',
                        style: TextStyle(
                          color: Color.fromARGB(244, 109, 53, 53),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center, // Centrando el texto
                      ),
                      _DropdownTipoServicio(),
                      _TextFieldHora(context),
                      _DropdownLugarVisita(),
                      _numeroPersona(context),
                      _TextFieldFechaInicio(context),
                      _TextFieldFechaFin(context),
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

  Widget _imageBackground(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: const Color.fromARGB(255, 241, 200, 113),
    );
  }

  Widget _DropdownTipoServicio() {
    String? _selectedServicio = state.tipo_servicio.value.isNotEmpty
        ? state.tipo_servicio.value
        : 'Tours'; // Valor inicial

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Tipo de Servicio',
          labelStyle: TextStyle(color: Colors.white, fontSize: 16),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
        ),
        dropdownColor: Colors.orange,
        value: _selectedServicio,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        items: [ 'Tours', 'Transporte']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: const TextStyle(color: Colors.white)),
          );
        }).toList(),
        onChanged: (newValue) {
          _selectedServicio = newValue;
          bloc?.add(Tipo_ServicioChanged(
              tipo_servicio: BlocFormItem(value: newValue ?? 'Desayuno')));
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Seleccione un tipo de servicio';
          }
          return state.tipo_servicio.error;
        },
      ),
    );
  }

  Widget _TextFieldHora(BuildContext context) {
    final TextEditingController _timeController = TextEditingController(
      text: state.hora.value,
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: _timeController,
        decoration: const InputDecoration(
          labelText: 'Hora',
          icon: Icon(Icons.access_time, color: Colors.white),
          labelStyle: TextStyle(color: Colors.white, fontSize: 16),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
        ),
        style: const TextStyle(color: Colors.white, fontSize: 16),
        readOnly: true,
        onTap: () async {
          TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: Colors.orange,
                ),
                child: child!,
              );
            },
          );

          if (pickedTime != null) {
            String formattedTime = pickedTime.format(context);
            _timeController.text = formattedTime;
            bloc?.add(HoraChanged(hora: BlocFormItem(value: formattedTime)));
          }
        },
      ),
    );
  }

  Widget _DropdownLugarVisita() {
    String? _selectedLugar = state.lugarVisita.value.isNotEmpty
        ? state.lugarVisita.value
        : 'Lamas'; // Valor inicial

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Lugar de Visita',
          labelStyle: TextStyle(color: Colors.white, fontSize: 16),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
        ),
        dropdownColor: Colors.orange,
        value: _selectedLugar,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        items: ['Lamas', 'Laguna azul', 'mirador tarapoto']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: const TextStyle(color: Colors.white)),
          );
        }).toList(),
        onChanged: (newValue) {
          _selectedLugar = newValue;
          bloc?.add(LugarVisitaChanged(
              lugarVisita: BlocFormItem(value: newValue ?? 'Lamas')));
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Seleccione un lugar de visita';
          }
          return state.lugarVisita.error;
        },
      ),
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
