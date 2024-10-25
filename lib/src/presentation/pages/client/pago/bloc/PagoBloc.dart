import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy_file_gp2/src/domain/models/AuthResponse.dart';
import 'package:shopy_file_gp2/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:shopy_file_gp2/src/domain/utils/Resource.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/pago/bloc/PagoState.dart';
import 'package:shopy_file_gp2/src/presentation/utils/BlocFormItem.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/pago/bloc/PagoEvent.dart';

class PagoAdded extends PagoEvent {
  final String numero_tarjeta;
  final String fecha_caducidad;
  final String codigo_seguridad;
  final String nombre_titular;
  final String monto;

  PagoAdded({
    required this.numero_tarjeta,
    required this.fecha_caducidad,
    required this.codigo_seguridad,
    required this.nombre_titular,
    required this.monto,
  });
}

class PagoBloc extends Bloc<PagoEvent, PagoState> {
  AuthUseCases authUseCases;

  PagoBloc(this.authUseCases) : super(PagoState()) {
    on<InitEventPago>(_onInitEventPago);
    on<numero_tarjetaChanged>(_onnumero_tarjetaChanged);
    on<fecha_caducidadChanged>(_onfecha_caducidadChanged);
    on<codigo_seguridadChanged>(_oncodigo_seguridadChanged);
    on<nombre_titularChanged>(_onnombre_titularChanged);
    on<montoChanged>(_onmontoChanged);
    on<PagoAdded>(_onPagoAdded); // Evento para agregar pago
  }

  final formKey = GlobalKey<FormState>();

  Future<void> _onInitEventPago(
      InitEventPago event, Emitter<PagoState> emit) async {
    emit(state.copyWith(formKey: formKey));
  }

  Future<void> _onnumero_tarjetaChanged(
      numero_tarjetaChanged event, Emitter<PagoState> emit) async {
    emit(state.copyWith(
        numero_tarjeta: BlocFormItem(
            value: event.numero_tarjeta.value,
            error: event.numero_tarjeta.value.isNotEmpty
                ? null
                : 'Ingrese el numero de tarjeta'),
        formKey: formKey));
  }

  Future<void> _onfecha_caducidadChanged(
      fecha_caducidadChanged event, Emitter<PagoState> emit) async {
    emit(state.copyWith(
        fecha_caducidad: BlocFormItem(
            value: event.fecha_caducidad.value,
            error: event.fecha_caducidad.value.isNotEmpty
                ? null
                : 'Ingrese la fecha de caducidad de la tarjeta'),
        formKey: formKey));
  }

  Future<void> _oncodigo_seguridadChanged(
      codigo_seguridadChanged event, Emitter<PagoState> emit) async {
    emit(state.copyWith(
        codigo_seguridad: BlocFormItem(
            value: event.codigo_seguridad.value,
            error: event.codigo_seguridad.value.isNotEmpty
                ? null
                : 'Ingrese codigo de seguridad'),
        formKey: formKey));
  }

  Future<void> _onnombre_titularChanged(
      nombre_titularChanged event, Emitter<PagoState> emit) async {
    emit(state.copyWith(
        nombre_titular: BlocFormItem(
            value: event.nombre_titular.value,
            error: event.nombre_titular.value.isNotEmpty
                ? null
                : 'Ingrese nombre del titular'),
        formKey: formKey));
  }

  Future<void> _onmontoChanged(
      montoChanged event, Emitter<PagoState> emit) async {
    emit(state.copyWith(
        monto: BlocFormItem(
            value: event.monto.value,
            error: event.monto.value.isNotEmpty ? null : 'Ingrese el monto'),
        formKey: formKey));
  }

  // Nuevo método para manejar el evento de agregar una reserva
  Future<void> _onPagoAdded(PagoAdded event, Emitter<PagoState> emit) async {
    // Aquí puedes manejar la lógica para agregar una nueva reserva
    emit(state.copyWith(
      numero_tarjeta: BlocFormItem(value: event.numero_tarjeta),
      fecha_caducidad: BlocFormItem(value: event.fecha_caducidad),
      codigo_seguridad: BlocFormItem(value: event.codigo_seguridad),
      nombre_titular: BlocFormItem(value: event.nombre_titular),
      monto: BlocFormItem(value: event.monto.toString()),
    ));
  }
}
