import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shopy_file_gp2/src/domain/utils/Resource.dart';
import 'package:shopy_file_gp2/src/presentation/utils/BlocFormItem.dart';

class PagoState extends Equatable {
  final BlocFormItem numero_tarjeta;
  final BlocFormItem fecha_caducidad;
  final BlocFormItem codigo_seguridad;
  final BlocFormItem nombre_titular;
  final BlocFormItem monto;
  final Resource? response;

  final GlobalKey<FormState>? formKey;

  const PagoState(
      {this.numero_tarjeta =
          const BlocFormItem(error: 'Ingrese el numero de tarjeta'),
      this.fecha_caducidad =
          const BlocFormItem(error: 'Ingrese la fecha de caducidad'),
      this.codigo_seguridad =
          const BlocFormItem(error: 'Ingrese el codigo de seguridad'),
      this.nombre_titular = const BlocFormItem(
          error: 'Ingrese el nombre del titular de la tarjeta'),
      this.monto = const BlocFormItem(error: 'Ingrese monto'),
      this.formKey,
      this.response});

  PagoState copyWith(
      {BlocFormItem? numero_tarjeta,
      fecha_caducidad,
      codigo_seguridad,
      nombre_titular,
      monto,
      Resource? response,
      GlobalKey<FormState>? formKey}) {
    return PagoState(
        numero_tarjeta: numero_tarjeta ?? this.numero_tarjeta,
        fecha_caducidad: fecha_caducidad ?? this.fecha_caducidad,
        codigo_seguridad: codigo_seguridad ?? this.codigo_seguridad,
        nombre_titular: nombre_titular ?? this.nombre_titular,
        monto: monto ?? this.monto,
        formKey: formKey,
        response: response);
  }

  @override
  List<Object?> get props => [
        numero_tarjeta,
        fecha_caducidad,
        codigo_seguridad,
        nombre_titular,
        monto,
        response
      ];
}
