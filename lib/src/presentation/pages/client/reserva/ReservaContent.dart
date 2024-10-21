import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/reserva/bloc/ReservaBloc.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/reserva/bloc/ReservaEvent.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/reserva/bloc/ReservaState.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/servicio/ClientHomeServicioPage.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/servicio/bloc/ServicioPage.dart';
import 'package:shopy_file_gp2/src/presentation/utils/BlocFormItem.dart';
import 'package:shopy_file_gp2/src/presentation/widget/DefaultTextField.dart';

class ReservaContent extends StatelessWidget {
  final ReservaBloc? bloc;
  final ReservaState state;

  ReservaContent(this.bloc, this.state);

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
            color: Colors.white, // Establece el color del ícono a blanco
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
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.height * 0.80,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 0.3),
                borderRadius: const BorderRadius.all(Radius.circular(25)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'RESERVAR',
                      style: TextStyle(
                        color: Color.fromARGB(244, 109, 53, 53),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _TextFieldnombre(),
                    _TextFieldapellido(),
                    _DropdownIdentidad(), // Dropdown para identidad
                    _DropdownTipoHabitacion(), // Dropdown para tipo de habitación
                    _TextFieldfechaInicio(context),
                    _TextFieldfechaFin(context), // Campo Fecha Fin
                    _TextFieldfechaReserva(context), // Campo Fecha Reserva
                    _RadioDesayunos(context),
                    _RadioServicios(context),
                    _buttonConfirmarReserva(context),
                  ],
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
      color: const Color.fromARGB(255, 241, 200, 113), // Marrón
    );
  }

  Widget _TextFieldnombre() {
    return _buildTextField(
      label: 'Nombre',
      icon: Icons.person,
      onChanged: (text) {
        bloc?.add(nombreChanged(nombre: BlocFormItem(value: text)));
      },
      validator: (value) => state.nombre.error,
    );
  }

  Widget _TextFieldapellido() {
    return _buildTextField(
      label: 'Apellido',
      icon: Icons.person,
      onChanged: (text) {
        bloc?.add(apellidoChanged(apellido: BlocFormItem(value: text)));
      },
      validator: (value) => state.apellido.error,
    );
  }

  Widget _DropdownIdentidad() {
    String? _selectedIdentidad = state.identidad.value.isNotEmpty
        ? state.identidad.value
        : 'DNI'; // Valor inicial

    final TextEditingController _controller =
        TextEditingController(); // Controlador para el campo de identidad

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 0),
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Identidad',
              icon: Icon(Icons.format_indent_decrease_rounded,
                  color: Colors.white), // Icono en blanco
              labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16), // Tamaño de fuente uniforme
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.white,
                    width: 2.0), // Línea blanca hasta los bordes
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.white, width: 2.0), // Línea blanca más gruesa
              ),
            ),
            dropdownColor: Colors.orange, // Fondo naranja
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16), // Texto del dropdown en blanco y uniforme
            value: _selectedIdentidad,
            icon: const Icon(Icons.arrow_drop_down,
                color: Colors.white), // Flecha blanca
            items: ['DNI', 'Pasaporte']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                    style: const TextStyle(
                        color: Colors.white)), // Texto en blanco
              );
            }).toList(),
            onChanged: (newValue) {
              _selectedIdentidad = newValue;
              bloc?.add(
                identidadChanged(
                    identidad: BlocFormItem(value: newValue ?? 'DNI')),
              );
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Seleccione un tipo de identidad';
              }
              return state.identidad.error;
            },
          ),
        ),
        const SizedBox(height: 16),

        // Campo de texto que depende de la identidad seleccionada
        TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: _selectedIdentidad == 'DNI'
                ? 'Ingrese su DNI (8 dígitos)'
                : 'Ingrese su Pasaporte (hasta 22 dígitos)',
            labelStyle: const TextStyle(
                color: Colors.white, fontSize: 16), // Texto blanco
            enabledBorder: const UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.white, width: 2.0), // Línea blanca
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white, width: 2.0), // Línea blanca más gruesa
            ),
          ),
          style: const TextStyle(
              color: Colors.white, fontSize: 16), // Color del texto ingresado
          keyboardType: TextInputType.number, // Solo números
          maxLength: _selectedIdentidad == 'DNI'
              ? 8
              : 22, // Límite de caracteres según la identidad
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Este campo es obligatorio';
            }

            // Validación del número de dígitos según la identidad seleccionada
            if (_selectedIdentidad == 'DNI' && value.length != 8) {
              return 'El DNI debe tener 8 dígitos';
            } else if (_selectedIdentidad == 'Pasaporte' && value.length > 22) {
              return 'El pasaporte debe tener hasta 22 dígitos';
            }

            return null;
          },
          onChanged: (value) {
            // Actualizar el estado con el valor ingresado
            bloc?.add(
              identidadChanged(identidad: BlocFormItem(value: value)),
            );
          },
        ),
      ],
    );
  }

  Widget _DropdownTipoHabitacion() {
    String? _selectedHabitacion = state.tipo_habitacion.value.isNotEmpty
        ? state.tipo_habitacion.value
        : 'Doble'; // Valor inicial
    int _cantidadHuespedes = 1; // Inicializar huéspedes

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dropdown de Tipo de Habitación
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 0),
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Tipo de Habitación',
              labelStyle: TextStyle(
                  color: Colors.white, fontSize: 16), // Tamaño uniforme
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.white, width: 2.0), // Línea blanca
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.white, width: 2.0), // Línea blanca más gruesa
              ),
            ),
            dropdownColor: Colors.orange, // Fondo naranja
            value: _selectedHabitacion,
            icon: const Icon(Icons.arrow_drop_down,
                color: Colors.white), // Flecha blanca
            items: ['Doble', 'Triple', 'Departamento'].map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16), // Texto blanco y tamaño uniforme
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              _selectedHabitacion = newValue;
              bloc?.add(tipo_habitacionChanged(
                  tipo_habitacion: BlocFormItem(value: newValue ?? 'Doble')));
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Seleccione un tipo de habitación';
              }
              return state.tipo_habitacion.error;
            },
          ),
        ),
        const SizedBox(height: 16),
        

        // Selector de Cantidad de Huéspedes
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            children: [
              // Botón de decremento
              IconButton(
                icon: const Icon(Icons.remove, color: Colors.white),
                onPressed: () {
                  if (_cantidadHuespedes > 1) {
                    _cantidadHuespedes--;
                  }
                },
              ),
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Cantidad de Huéspedes',
                    labelStyle: TextStyle(
                        color: Colors.white, fontSize: 16), // Tamaño uniforme
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white, width: 2.0), // Línea blanca
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white,
                          width: 2.0), // Línea blanca más gruesa
                    ),
                  ),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16), // Tamaño y color uniforme
                  controller:
                      TextEditingController(text: '$_cantidadHuespedes'),
                ),
              ),
              // Botón de incremento
              IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  _cantidadHuespedes++;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _TextFieldfechaInicio(BuildContext context) {
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
            bloc?.add(fechaInicioChanged(
                fechaInicio: BlocFormItem(value: formattedDate)));
          }
        },
      ),
    );
  }

  Widget _TextFieldfechaFin(BuildContext context) {
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
              bloc?.add(fechaFinChanged(
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

  Widget _TextFieldfechaReserva(BuildContext context) {
    final TextEditingController _dateController = TextEditingController(
      text: state.fechaReserva.value,
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      child: TextFormField(
        controller: _dateController,
        decoration: const InputDecoration(
          labelText: 'Fecha Reserva',
          icon: Icon(Icons.calendar_today, color: Colors.white),
          labelStyle:
              TextStyle(color: Colors.white, fontSize: 16), // Tamaño uniforme
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white, width: 2.0), // Línea blanca hasta el borde
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white, width: 2.0), // Línea blanca más gruesa
          ),
        ),
        style: const TextStyle(
            color: Colors.white, fontSize: 16), // Tamaño y color uniforme
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
            String formattedDate =
                "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
            _dateController.text = formattedDate;
            bloc?.add(fechaReservaChanged(
                fechaReserva: BlocFormItem(value: formattedDate)));
          }
        },
        validator: (value) {
          return state.fechaReserva.error;
        },
      ),
    );
  }

  // Implementación del campo para Desayunos
  Widget _RadioDesayunos(BuildContext context) {
    String _selectedDesayunos = 'No'; // Valor inicial

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Desayunos',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        RadioListTile<String>(
          title: const Text('Sí', style: TextStyle(color: Colors.white)),
          value: 'Sí',
          groupValue: _selectedDesayunos,
          activeColor: Colors.orange,
          onChanged: (newValue) {
            _selectedDesayunos = newValue!;
            if (newValue == 'Sí') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ServicioPage()), // Lleva a la página de Desayunos
              );
            }
          },
        ),
        RadioListTile<String>(
          title: const Text('No', style: TextStyle(color: Colors.white)),
          value: 'No',
          groupValue: _selectedDesayunos,
          activeColor: Colors.orange,
          onChanged: (newValue) {
            _selectedDesayunos = newValue!;
          },
        ),
      ],
    );
  }

// Implementación del campo para Servicios Adicionales
  Widget _RadioServicios(BuildContext context) {
    String _selectedServicios = 'No'; // Valor inicial

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Servicios Adicionales',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        RadioListTile<String>(
          title: const Text('Sí', style: TextStyle(color: Colors.white)),
          value: 'Sí',
          groupValue: _selectedServicios,
          activeColor: Colors.orange,
          onChanged: (newValue) {
            _selectedServicios = newValue!;
            if (newValue == 'Sí') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ClientHomeServicioPage()), // Lleva a la página de Servicios Adicionales
              );
            }
          },
        ),
        RadioListTile<String>(
          title: const Text('No', style: TextStyle(color: Colors.white)),
          value: 'No',
          groupValue: _selectedServicios,
          activeColor: Colors.orange,
          onChanged: (newValue) {
            _selectedServicios = newValue!;
          },
        ),
      ],
    );
  }

  Widget _buttonConfirmarReserva(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: ElevatedButton(
        onPressed: () {
          if (state.formKey!.currentState!.validate()) {
            bloc?.add(ReservaSubmit());
          } else {
            Fluttertoast.showToast(
              msg: 'Reserva no confirmada',
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
