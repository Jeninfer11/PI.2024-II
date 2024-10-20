import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shopy_file_gp2/src/domain/utils/Resource.dart';
import 'package:shopy_file_gp2/src/presentation/utils/BlocFormItem.dart';

class ReservaState extends Equatable {
  final BlocFormItem nombre;
  final BlocFormItem apellido;
  final BlocFormItem identidad;
  final BlocFormItem tipo_habitacion;
  final BlocFormItem fechaInicio;
  final BlocFormItem fechaFin;
  final BlocFormItem fechaReserva;
  final Resource? response;

  final GlobalKey<FormState>? formKey;

  const ReservaState(
      {this.nombre = const BlocFormItem(error: 'Ingresa email'),
      this.apellido = const BlocFormItem(error: 'Ingrese su password'),
      this.identidad = const BlocFormItem(error: 'Ingrese su password'),
      this.tipo_habitacion = const BlocFormItem(error: 'Ingrese su password'),
      this.fechaInicio = const BlocFormItem(error: 'Ingrese su password'),
      this.fechaFin = const BlocFormItem(error: 'Ingrese su password'),
      this.fechaReserva = const BlocFormItem(error: 'Ingrese su password'),
      this.formKey,
      this.response});

  ReservaState copyWith(
      {BlocFormItem? nombre,
      apellido,
      identidad,
      tipo_habitacion,
      fechaInicio,
      fechaFin,
      fechaReserva,
      Resource? response,
      GlobalKey<FormState>? formKey}) {
    return ReservaState(
        nombre: nombre ?? this.nombre,
        apellido: apellido ?? this.apellido,
        identidad: identidad ?? this.identidad,
        tipo_habitacion: tipo_habitacion ?? this.tipo_habitacion,
        fechaInicio: fechaInicio ?? this.fechaInicio,
        fechaFin: fechaFin ?? this.fechaFin,
        fechaReserva: fechaReserva ?? this.fechaReserva,
        formKey: formKey,
        response: response);
  }

  @override
  List<Object?> get props => [
        nombre,
        apellido,
        identidad,
        tipo_habitacion,
        fechaInicio,
        fechaFin,
        fechaReserva,
        response
      ];
}
