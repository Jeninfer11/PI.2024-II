import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy_file_gp2/src/domain/models/AuthResponse.dart';
import 'package:shopy_file_gp2/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:shopy_file_gp2/src/domain/utils/Resource.dart';
import 'package:shopy_file_gp2/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/reserva/bloc/ReservaEvent.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/reserva/bloc/ReservaState.dart';
import 'package:shopy_file_gp2/src/presentation/utils/BlocFormItem.dart';

// Define un nuevo evento para agregar una reserva
class ReservaAdded extends ReservaEvent {
  final String nombre;
  final String apellido;
  final String identidad;
  final String tipoHabitacion;
  final String fechaInicio;
  final String fechaFin;
  final String fechaReserva;

  ReservaAdded({
    required this.nombre,
    required this.apellido,
    required this.identidad,
    required this.tipoHabitacion,
    required this.fechaInicio,
    required this.fechaFin,
    required this.fechaReserva,
  });
}

class ReservaBloc extends Bloc<ReservaEvent, ReservaState> {
  AuthUseCases authUseCases;

  ReservaBloc(this.authUseCases) : super(ReservaState()) {
    on<InitEventReserva>(_onInitEventReserva);
    on<nombreChanged>(_onnombreChanged);
    on<apellidoChanged>(_onapellidoChanged);
    on<identidadChanged>(_onidentidadChanged);
    on<tipo_habitacionChanged>(_ontipo_habitacionChanged);
    on<fechaInicioChanged>(_onfechaInicioChanged);
    on<fechaFinChanged>(_onfechaFinChanged);
    on<fechaReservaChanged>(_onfechaReservaChanged);
    on<fechaReservaChanged>(_onfechaReservaChanged);
    on<ReservaAdded>(
        _onReservaAdded); // Maneja el evento de agregar una reserva
  }
  final formKey = GlobalKey<FormState>();

  Future<void> _onInitEventReserva(
      InitEventReserva event, Emitter<ReservaState> emit) async {
    AuthResponse? authResponse = await authUseCases.getUserSession.run();
    emit(state.copyWith(formKey: formKey));
    print('Usuario en seccion: ${authResponse?.toJson()}');
    if (authResponse != null) {
      emit(state.copyWith(response: Success(authResponse), formKey: formKey));
    }
  }

  Future<void> _onnombreChanged(
      nombreChanged event, Emitter<ReservaState> emit) async {
    emit(state.copyWith(
        nombre: BlocFormItem(
            value: event.nombre.value,
            error: event.nombre.value.isNotEmpty ? null : 'Ingresa el nombre'),
        formKey: formKey));
  }

  Future<void> _onapellidoChanged(
      apellidoChanged event, Emitter<ReservaState> emit) async {
    emit(state.copyWith(
        apellido: BlocFormItem(
            value: event.apellido.value,
            error:
                event.apellido.value.isNotEmpty ? null : 'Ingresa el apellido'),
        formKey: formKey));
  }

  Future<void> _onidentidadChanged(
      identidadChanged event, Emitter<ReservaState> emit) async {
    emit(state.copyWith(
        identidad: BlocFormItem(
            value: event.identidad.value,
            error: event.identidad.value.isNotEmpty
                ? null
                : 'Ingresa la identidad'),
        formKey: formKey));
  }

  Future<void> _ontipo_habitacionChanged(
      tipo_habitacionChanged event, Emitter<ReservaState> emit) async {
    emit(state.copyWith(
        tipo_habitacion: BlocFormItem(
            value: event.tipo_habitacion.value,
            error: event.tipo_habitacion.value.isNotEmpty
                ? null
                : 'Ingresa el tipo de habitación'),
        formKey: formKey));
  }

  Future<void> _onfechaInicioChanged(
      fechaInicioChanged event, Emitter<ReservaState> emit) async {
    emit(state.copyWith(
        fechaInicio: BlocFormItem(
            value: event.fechaInicio.value,
            error: event.fechaInicio.value.isNotEmpty
                ? null
                : 'Ingresa la fecha de inicio'),
        formKey: formKey));
  }

  Future<void> _onfechaFinChanged(
      fechaFinChanged event, Emitter<ReservaState> emit) async {
    emit(state.copyWith(
        fechaFin: BlocFormItem(
            value: event.fechaFin.value,
            error: event.fechaFin.value.isNotEmpty
                ? null
                : 'Ingresa la fecha de fin'),
        formKey: formKey));
  }

  Future<void> _onfechaReservaChanged(
      fechaReservaChanged event, Emitter<ReservaState> emit) async {
    emit(state.copyWith(
        fechaReserva: BlocFormItem(
            value: event.fechaReserva.value,
            error: event.fechaReserva.value.isNotEmpty
                ? null
                : 'Ingresa la fecha de la reserva'),
        formKey: formKey));
  }

  // Nuevo método para manejar el evento de agregar una reserva
  Future<void> _onReservaAdded(
      ReservaAdded event, Emitter<ReservaState> emit) async {
    // Aquí puedes manejar la lógica para agregar una nueva reserva
    emit(state.copyWith(
      nombre: BlocFormItem(value: event.nombre),
      apellido: BlocFormItem(value: event.apellido),
      identidad: BlocFormItem(value: event.identidad),
      tipo_habitacion: BlocFormItem(value: event.tipoHabitacion),
      fechaInicio: BlocFormItem(value: event.fechaInicio),
      fechaFin: BlocFormItem(value: event.fechaFin),
      fechaReserva: BlocFormItem(value: event.fechaReserva),
    ));
  }
}
