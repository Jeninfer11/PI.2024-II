import 'package:equatable/equatable.dart';
import 'package:shopy_file_gp2/src/presentation/utils/BlocFormItem.dart';

abstract class PagoEvent extends Equatable {
  const PagoEvent();

  @override
  List<Object?> get props => [];
}

class InitEventPago extends PagoEvent {
  const InitEventPago();
}

class numero_tarjetaChanged extends PagoEvent {
  final BlocFormItem numero_tarjeta;

  numero_tarjetaChanged({required this.numero_tarjeta});

  @override
  List<Object?> get props => [numero_tarjeta];
}

class fecha_caducidadChanged extends PagoEvent {
  final BlocFormItem fecha_caducidad;

  fecha_caducidadChanged({required this.fecha_caducidad});

  @override
  List<Object?> get props => [fecha_caducidad];
}

class codigo_seguridadChanged extends PagoEvent {
  final BlocFormItem codigo_seguridad;

  codigo_seguridadChanged({required this.codigo_seguridad});

  @override
  List<Object?> get props => [codigo_seguridad];
}

class nombre_titularChanged extends PagoEvent {
  final BlocFormItem nombre_titular;

  nombre_titularChanged({required this.nombre_titular});

  @override
  List<Object?> get props => [nombre_titular];
}

class montoChanged extends PagoEvent {
  final BlocFormItem monto;

  montoChanged({required this.monto});

  @override
  List<Object?> get props => [monto];
}

class PagoSubmit extends PagoEvent {
  const PagoSubmit();
}
