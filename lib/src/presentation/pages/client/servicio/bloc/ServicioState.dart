import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shopy_file_gp2/src/domain/utils/Resource.dart';
import 'package:shopy_file_gp2/src/presentation/utils/BlocFormItem.dart';

class ServicioState extends Equatable {
  final BlocFormItem nombre;
  final BlocFormItem tipo_servicio;
  final BlocFormItem lugarVisita; // Solo para el tour
  final BlocFormItem hora; // Hora del servicio
  final BlocFormItem numeroPersona;
  final BlocFormItem fechaInicio;
  final BlocFormItem fechaFin;
  final Resource? response;

  final GlobalKey<FormState>? formKey;

  const ServicioState({
    this.nombre = const BlocFormItem(error: 'Ingrese nombre'),
    this.tipo_servicio = const BlocFormItem(error: 'Ingrese tipo de servicio'),
    this.lugarVisita = const BlocFormItem(error: 'Ingrese lugar visita'),
    this.hora = const BlocFormItem(error: 'Ingrese hora'),
    this.numeroPersona =
        const BlocFormItem(error: 'Ingrese número de personas'),
    this.fechaInicio = const BlocFormItem(error: 'Ingrese fecha de inicio'),
    this.fechaFin = const BlocFormItem(error: 'Ingrese fecha de fin'),
    this.formKey,
    this.response,
  });

  ServicioState copyWith({
    BlocFormItem? nombre,
    BlocFormItem? tipo_servicio,
    BlocFormItem? lugarVisita,
    BlocFormItem? hora,
    BlocFormItem? numeroPersona,
    BlocFormItem? fechaInicio,
    BlocFormItem? fechaFin,
    Resource? response,
    GlobalKey<FormState>? formKey,
  }) {
    return ServicioState(
      nombre: nombre ?? this.nombre,
      tipo_servicio: tipo_servicio ?? this.tipo_servicio,
      lugarVisita: lugarVisita ?? this.lugarVisita,
      hora: hora ?? this.hora,
      numeroPersona: numeroPersona ?? this.numeroPersona,
      fechaInicio: fechaInicio ?? this.fechaInicio,
      fechaFin: fechaFin ?? this.fechaFin,
      formKey: formKey,
      response: response,
    );
  }

  @override
  List<Object?> get props => [
        nombre,
        tipo_servicio,
        lugarVisita,
        hora,
        numeroPersona,
        fechaInicio,
        fechaFin,
        response,
      ];
}
