import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy_file_gp2/src/domain/models/AuthResponse.dart';
import 'package:shopy_file_gp2/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:shopy_file_gp2/src/domain/utils/Resource.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/servicio/bloc/ServicioEvent.dart';
import 'package:shopy_file_gp2/src/presentation/pages/client/servicio/bloc/ServicioState.dart';
import 'package:shopy_file_gp2/src/presentation/utils/BlocFormItem.dart';

// servicio.dart
class ServicioAdded extends ServicioEvent {
  final String nombre; // Desayuno, Tour, Recogida
  final String image;
  final String tipo_servicio;
  final String lugarVisita; // Solo para el tour
  final String hora; // Hora del servicio
  final int numeroPersona;
  final String fechaInicio;
  final String fechaFin;
  // Cantidad de personas

  ServicioAdded({
    required this.nombre,
    required this.image,
    required this.tipo_servicio,
    required this.lugarVisita,
    required this.hora,
    required this.numeroPersona,
    required this.fechaInicio,
    required this.fechaFin,
  });
}

class ServicioBloc extends Bloc<ServicioEvent, ServicioState> {
  AuthUseCases authUseCases;

  ServicioBloc(this.authUseCases) : super(ServicioState()) {
    on<InitEventServicio>(_onInitEventServicio);
    on<NombreChanged>(_onnombreChanged);
    on<Tipo_ServicioChanged>(_ontipo_ServicioChanged);
    on<LugarVisitaChanged>(_onlugarVisitaChanged);
    on<HoraChanged>(_onhoraChanged);
    on<NumeroPersonaChanged>(_onnumeroPersonaChanged);
    on<FechaInicioChanged>(_onfechaInicioChanged);
    on<FechaFinChanged>(_onfechaFinChanged);
    on<ServicioAdded>(_onServicioAdded); // Evento para agregar el servicio
  }

  final formKey = GlobalKey<FormState>();

  Future<void> _onInitEventServicio(
      InitEventServicio event, Emitter<ServicioState> emit) async {
    AuthResponse? authResponse = await authUseCases.getUserSession.run();
    emit(state.copyWith(formKey: formKey));
    print('Usuario en sesión: ${authResponse?.toJson()}');
    if (authResponse != null) {
      emit(state.copyWith(response: Success(authResponse), formKey: formKey));
    }
  }

  Future<void> _onnombreChanged(
      NombreChanged event, Emitter<ServicioState> emit) async {
    emit(state.copyWith(
        nombre: BlocFormItem(
            value: event.nombre.value,
            error: event.nombre.value.isNotEmpty ? null : 'Ingrese el nombre'),
        formKey: formKey));
  }

  Future<void> _ontipo_ServicioChanged(
      Tipo_ServicioChanged event, Emitter<ServicioState> emit) async {
    emit(state.copyWith(
        tipo_servicio: BlocFormItem(
            value: event.tipo_servicio.value,
            error: event.tipo_servicio.value.isNotEmpty
                ? null
                : 'Ingrese el tipo de servicio'),
        formKey: formKey));
  }

  Future<void> _onlugarVisitaChanged(
      LugarVisitaChanged event, Emitter<ServicioState> emit) async {
    emit(state.copyWith(
        lugarVisita: BlocFormItem(
            value: event.lugarVisita.value,
            error: event.lugarVisita.value.isNotEmpty
                ? null
                : 'Ingrese el lugar de visita'),
        formKey: formKey));
  }

  Future<void> _onhoraChanged(
      HoraChanged event, Emitter<ServicioState> emit) async {
    emit(state.copyWith(
        hora: BlocFormItem(
            value: event.hora.value,
            error: event.hora.value.isNotEmpty
                ? null
                : 'Ingrese la hora del servicio'),
        formKey: formKey));
  }

  Future<void> _onnumeroPersonaChanged(
      NumeroPersonaChanged event, Emitter<ServicioState> emit) async {
    emit(state.copyWith(
        numeroPersona: BlocFormItem(
            value: event.numeroPersona.value,
            error: event.numeroPersona.value.isNotEmpty
                ? null
                : 'Ingrese el número de personas'),
        formKey: formKey));
  }

  Future<void> _onfechaInicioChanged(
      FechaInicioChanged event, Emitter<ServicioState> emit) async {
    emit(state.copyWith(
        fechaInicio: BlocFormItem(
            value: event.fechaInicio.value,
            error: event.fechaInicio.value.isNotEmpty
                ? null
                : 'Ingrese la fecha de inicio'),
        formKey: formKey));
  }

  Future<void> _onfechaFinChanged(
      FechaFinChanged event, Emitter<ServicioState> emit) async {
    emit(state.copyWith(
        fechaFin: BlocFormItem(
            value: event.fechaFin.value,
            error: event.fechaFin.value.isNotEmpty
                ? null
                : 'Ingrese la fecha de fin'),
        formKey: formKey));
  }

  // Nuevo método para manejar el evento de agregar una reserva
  Future<void> _onServicioAdded(
      ServicioAdded event, Emitter<ServicioState> emit) async {
    // Aquí puedes manejar la lógica para agregar una nueva reserva
    emit(state.copyWith(
      nombre: BlocFormItem(value: event.nombre),
      tipo_servicio: BlocFormItem(value: event.tipo_servicio),
      lugarVisita: BlocFormItem(value: event.lugarVisita),
      hora: BlocFormItem(value: event.hora),
      numeroPersona: BlocFormItem(value: event.numeroPersona.toString()),
      fechaInicio: BlocFormItem(value: event.fechaInicio),
      fechaFin: BlocFormItem(value: event.fechaFin),
    ));
  }
}
