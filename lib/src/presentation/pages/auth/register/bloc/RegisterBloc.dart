import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy_file_gp2/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:shopy_file_gp2/src/domain/utils/Resource.dart';
import 'package:shopy_file_gp2/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';
import 'package:shopy_file_gp2/src/presentation/pages/auth/register/bloc/RegisterState.dart';
import 'package:shopy_file_gp2/src/presentation/utils/BlocFormItem.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  AuthUseCases authUseCases;

  RegisterBloc(this.authUseCases) : super(RegisterState()) {
    on<RegisterInitEvent>(_onInitEvent);
    on<RegisterNameChanged>(_onNameChanged);
    on<RegisterLastnameChanged>(_onLastNameChanged);
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPhoneChanged>(_onPhoneChanged);
    on<RegisterdniChanged>(_ondniChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<RegisterFormSubmit>(_onRegisterSubmit);
    on<RegisterFormReset>(_onRegisterFormReset);
  }
  final formKey = GlobalKey<FormState>();

  Future<void> _onInitEvent(
      RegisterInitEvent event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(formKey: formKey));
  }

  Future<void> _onNameChanged(
      RegisterNameChanged event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(
        name: BlocFormItem(
            value: event.name.value,
            error: event.name.value.isNotEmpty ? null : 'Ingresa nombre'),
        formKey: formKey));
  }

  Future<void> _onLastNameChanged(
      RegisterLastnameChanged event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(
        lastname: BlocFormItem(
            value: event.lastname.value,
            error: event.lastname.value.isNotEmpty ? null : 'Ingresa apellido'),
        formKey: formKey));
  }

  Future<void> _onEmailChanged(
      RegisterEmailChanged event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(
        email: BlocFormItem(
            value: event.email.value,
            error: event.email.value.isNotEmpty ? null : 'Ingresa email'),
        formKey: formKey));
  }

  Future<void> _ondniChanged(
      RegisterdniChanged event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(
        dni: BlocFormItem(
            value: event.dni.value,
            error: event.dni.value.isNotEmpty ? null : 'Ingresa dni'),
        formKey: formKey));
  }

  Future<void> _onPhoneChanged(
      RegisterPhoneChanged event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(
        phone: BlocFormItem(
            value: event.phone.value,
            error: event.phone.value.isNotEmpty ? null : 'Ingresa telefono'),
        formKey: formKey));
  }

  Future<void> _onPasswordChanged(
      RegisterPasswordChanged event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(
        password: BlocFormItem(
            value: event.password.value,
            error:
                event.password.value.isNotEmpty ? null : 'Ingresa el password'),
        formKey: formKey));
  }

  Future<void> _onConfirmPasswordChanged(
      RegisterConfirmPasswordChanged event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(
        confirmpasword: BlocFormItem(
            value: event.confirmpassword.value,
            error: event.confirmpassword.value.isNotEmpty
                ? null
                : 'Ingresa el password'),
        formKey: formKey));
  }

  Future<void> _onRegisterSubmit(
      RegisterFormSubmit event, Emitter<RegisterState> emit) async {
    emit(
      state.copyWith(response: Loading(), formKey: formKey),
    );
    await Future.delayed(Duration(seconds: 6));
    Resource response = await authUseCases.register.run(state.toUser());
    emit(state.copyWith(response: response, formKey: formKey));
  }

  Future<void> _onRegisterFormReset(
      RegisterFormReset event, Emitter<RegisterState> emit) async {
    state.formKey?.currentState?.reset();
  }
}
