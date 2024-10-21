import 'package:equatable/equatable.dart';
import 'package:shopy_file_gp2/src/presentation/utils/BlocFormItem.dart';

abstract class ServicioEvent extends Equatable {
  const ServicioEvent();

  @override
  List<Object?> get props => [];
}

class InitEventServicio extends ServicioEvent {
  const InitEventServicio();
}

class NombreChanged extends ServicioEvent {
  final BlocFormItem nombre;

  NombreChanged({required this.nombre});

  @override
  List<Object?> get props => [nombre];
}

class Tipo_ServicioChanged extends ServicioEvent {
  final BlocFormItem tipo_servicio;

  Tipo_ServicioChanged({required this.tipo_servicio});

  @override
  List<Object?> get props => [tipo_servicio];
}

class LugarVisitaChanged extends ServicioEvent {
  final BlocFormItem lugarVisita;

  LugarVisitaChanged({required this.lugarVisita});

  @override
  List<Object?> get props => [lugarVisita];
}

class HoraChanged extends ServicioEvent {
  final BlocFormItem hora;

  HoraChanged({required this.hora});

  @override
  List<Object?> get props => [hora];
}

class NumeroPersonaChanged extends ServicioEvent {
  final BlocFormItem numeroPersona;

  NumeroPersonaChanged({required this.numeroPersona});

  @override
  List<Object?> get props => [numeroPersona];
}

class FechaInicioChanged extends ServicioEvent {
  final BlocFormItem fechaInicio;

  FechaInicioChanged({required this.fechaInicio});

  @override
  List<Object?> get props => [fechaInicio];
}

class FechaFinChanged extends ServicioEvent {
  final BlocFormItem fechaFin;

  FechaFinChanged({required this.fechaFin});

  @override
  List<Object?> get props => [fechaFin];
}

class ServicioSubmit extends ServicioEvent {
  const ServicioSubmit();
}
