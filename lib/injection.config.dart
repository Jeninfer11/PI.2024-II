// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shopy_file_gp2/src/data/dataSource/local/SharePref.dart'
    as _i269;
import 'package:shopy_file_gp2/src/data/dataSource/remote/services/AuthServices.dart'
    as _i849;
import 'package:shopy_file_gp2/src/di/AppModule.dart' as _i900;
import 'package:shopy_file_gp2/src/domain/repository/AuthRepository.dart'
    as _i902;
import 'package:shopy_file_gp2/src/domain/useCases/auth/AuthUseCases.dart'
    as _i406;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i269.SharedPrefe>(() => appModule.sharedPrefe);
    gh.factory<_i849.AuthServices>(() => appModule.authServices);
    gh.factory<_i902.AuthRepository>(() => appModule.authRepository);
    gh.factory<_i406.AuthUseCases>(() => appModule.authUseCases);
    return this;
  }
}

class _$AppModule extends _i900.AppModule {}
