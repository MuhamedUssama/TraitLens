// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/data_source/auth_data_source.dart' as _i364;
import '../../features/auth/data/data_source_impl/auth_data_source_impl.dart'
    as _i105;
import '../../features/auth/data/repository_impl/auth_repository_impl.dart'
    as _i954;
import '../../features/auth/domain/repository/auth_repository.dart' as _i961;
import '../../features/auth/domain/use_cases/sign_in_with_email_and_password_usecase.dart'
    as _i780;
import '../../features/auth/domain/use_cases/sign_in_with_facebook_usecase.dart'
    as _i952;
import '../../features/auth/domain/use_cases/sign_in_with_google_usecase.dart'
    as _i645;
import '../../features/auth/domain/use_cases/sign_out_usecase.dart' as _i399;
import '../../features/auth/domain/use_cases/sign_up_with_email_and_password_usecase.dart'
    as _i217;
import '../../features/auth/domain/use_cases/verify_account_usecase.dart'
    as _i3;
import '../../features/auth/view/view_models/sign_up_view_model/sign_up_view_model.dart'
    as _i195;
import '../cache/shared_preferences.dart' as _i254;

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
    gh.singleton<_i254.SharedPreferencesHelper>(
        () => _i254.SharedPreferencesHelper());
    gh.factory<_i364.AuthDataSource>(() => _i105.AuthDataSourceImpl());
    gh.factory<_i961.AuthRepository>(
        () => _i954.AuthRepositoryImpl(gh<_i364.AuthDataSource>()));
    gh.factory<_i780.SignInWithEmailAndPasswordUsecase>(() =>
        _i780.SignInWithEmailAndPasswordUsecase(gh<_i961.AuthRepository>()));
    gh.factory<_i952.SignInWithFacebookUsecase>(
        () => _i952.SignInWithFacebookUsecase(gh<_i961.AuthRepository>()));
    gh.factory<_i645.SignInWithGoogleUsecase>(
        () => _i645.SignInWithGoogleUsecase(gh<_i961.AuthRepository>()));
    gh.factory<_i399.SignOutUsecase>(
        () => _i399.SignOutUsecase(gh<_i961.AuthRepository>()));
    gh.factory<_i217.SignUpWithEmailAndPasswordUsecase>(() =>
        _i217.SignUpWithEmailAndPasswordUsecase(gh<_i961.AuthRepository>()));
    gh.factory<_i3.VerifyAccountUsecase>(
        () => _i3.VerifyAccountUsecase(gh<_i961.AuthRepository>()));
    gh.factory<_i195.SignUpViewModel>(() => _i195.SignUpViewModel(
          gh<_i217.SignUpWithEmailAndPasswordUsecase>(),
          gh<_i645.SignInWithGoogleUsecase>(),
          gh<_i952.SignInWithFacebookUsecase>(),
          gh<_i3.VerifyAccountUsecase>(),
        ));
    return this;
  }
}
