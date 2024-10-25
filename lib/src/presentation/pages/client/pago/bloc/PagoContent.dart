import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/pago/bloc/PagoBloc.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/pago/bloc/PagoState.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/reserva/ReservaPage.dart';

class PagoContent extends StatelessWidget {
  final PagoBloc? bloc;
  final PagoState state;

  PagoContent(this.bloc, this.state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purma Wasi'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 211, 169, 114),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white, // Color del ícono a blanco
          ),
          onPressed: () {
            Navigator.pop(context); // Volver a la pantalla principal
          },
        ),
      ),
      body: SingleChildScrollView(
        // Agregado para permitir desplazamiento
        child: Container(
          color:
              const Color.fromARGB(255, 244, 231, 220), // Color de fondo claro
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                // Centrar el texto "Método de pago"
                child: Text(
                  'Método de pago',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Resumen del pedido
              _resumenPedido(),

              SizedBox(height: 20),

              // Campo para ingresar detalles de pago
              _formularioPago(),

              SizedBox(height: 20),

              // Botón de Confirmar Pago
              _botonConfirmarPago(context),
            ],
          ),
        ),
      ),
    );
  }

  // Widget de resumen del pedido
  Widget _resumenPedido() {
    return Container(
      padding:
          const EdgeInsets.all(16), // Espacio interno dentro del contenedor
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 247, 218, 183), // Color de fondo beige
        borderRadius: BorderRadius.circular(12), // Bordes semi-redondeados
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Centrar los textos dentro del resumen
        children: [
          Text(
            'Habitación: \S/.50.00',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'Servicios: \S/.25.00',
            style: TextStyle(fontSize: 16),
          ),
          Divider(),
          Text(
            'Total: \S/.75.00',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Formulario para ingresar detalles del pago
  Widget _formularioPago() {
    return Container(
      padding:
          const EdgeInsets.all(16), // Espacio interno dentro del contenedor
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 247, 218, 183), // Color de fondo beige
        borderRadius: BorderRadius.circular(12), // Bordes semi-redondeados
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            // Centrar el texto "Método de pago"
            child: Text(
              'Pago con Tarjeta',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          // Campo Número de tarjeta
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Número de tarjeta',
              border: OutlineInputBorder(),
              prefixIcon:
                  Icon(Icons.credit_card), // Ícono de tarjeta de crédito
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 15),

          // Campo Nombre del titular
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Nombre del titular',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person), // Ícono de persona
            ),
          ),
          SizedBox(height: 15),

          // Filas de fecha de vencimiento y CVV
          Row(
            children: [
              // Campo Fecha de vencimiento
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Fecha de vencimiento',
                    border: OutlineInputBorder(),
                    prefixIcon:
                        Icon(Icons.calendar_today), // Ícono de calendario
                  ),
                  keyboardType: TextInputType.datetime,
                ),
              ),
              SizedBox(width: 15),

              // Campo CVV
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'CVV',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock), // Ícono de candado
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Botón de Confirmar Pago
  Widget _botonConfirmarPago(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment
            .spaceBetween, // Esto alinea los botones a la izquierda y derecha
        children: [
          // Botón Pagar
          SizedBox(
            width: 150, // Cambia el ancho a un valor específico si es necesario
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                    255, 238, 173, 59), // Color del botón de pagar
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Navega a la ventana de la reserva
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ReservaPage()), // Asegúrate de que ReservaPage esté definida
                );
              },
              child: Text(
                'Cancelar',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),

          // Botón Cancelar
          SizedBox(
            width: 150, // Cambia el ancho a un valor específico si es necesario
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                    255, 239, 178, 73), // Color del botón de cancelar
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Navega a la ventana de la reserva
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ReservaPage()), // Asegúrate de que ReservaPage esté definida
                );
              },
              child: Text(
                'Pagar',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
