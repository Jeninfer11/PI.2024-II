import 'package:equatable/equatable.dart';
import 'package:shopy_file_gp2/src/presentation/utils/BlocFormItem.dart';

abstract class ReservaEvent extends Equatable {
  const ReservaEvent();
  @override
  List<Object?> get props => [];
}

class InitEventReserva extends ReservaEvent {
  const InitEventReserva();
}

class nombreChanged extends ReservaEvent {
  final BlocFormItem nombre;
  const nombreChanged({required this.nombre});
  @override
  List<Object?> get props => [nombre];
}

class apellidoChanged extends ReservaEvent {
  final BlocFormItem apellido;
  const apellidoChanged({required this.apellido});
  @override
  List<Object?> get props => [apellido];
}

class identidadChanged extends ReservaEvent {
  final BlocFormItem identidad;
  const identidadChanged({required this.identidad});
  @override
  List<Object?> get props => [identidad];
}

class tipo_habitacionChanged extends ReservaEvent {
  final BlocFormItem tipo_habitacion;
  const tipo_habitacionChanged({required this.tipo_habitacion});
  @override
  List<Object?> get props => [tipo_habitacion];
}

class fechaInicioChanged extends ReservaEvent {
  final BlocFormItem fechaInicio;
  const fechaInicioChanged({required this.fechaInicio});
  @override
  List<Object?> get props => [fechaInicio];
}

class fechaFinChanged extends ReservaEvent {
  final BlocFormItem fechaFin;
  const fechaFinChanged({required this.fechaFin});
  @override
  List<Object?> get props => [fechaFin];
}

class fechaReservaChanged extends ReservaEvent {
  final BlocFormItem fechaReserva;
  const fechaReservaChanged({required this.fechaReserva});
  @override
  List<Object?> get props => [fechaReserva];
}

class ReservaSubmit extends ReservaEvent {
  const ReservaSubmit();
}
