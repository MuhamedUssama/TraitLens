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
import '../../features/auth/domain/use_cases/forget_password_usecase.dart'
    as _i27;
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
import '../../features/auth/view/view_models/forget_password_view_model/forget_password_view_model.dart'
    as _i247;
import '../../features/auth/view/view_models/sign_in_view_model/sign_in_view_model.dart'
    as _i615;
import '../../features/auth/view/view_models/sign_up_view_model/sign_up_view_model.dart'
    as _i195;
import '../../features/fill_profile/data/data_source/fill_profile_data_source.dart'
    as _i760;
import '../../features/fill_profile/data/data_source_impl/fill_profile_data_source_impl.dart'
    as _i186;
import '../../features/fill_profile/data/repository_impl/fill_profile_repository_impl.dart'
    as _i325;
import '../../features/fill_profile/domain/repository/fill_profile_repository.dart'
    as _i89;
import '../../features/fill_profile/domain/usecases/fill_profile_data_usecase.dart'
    as _i49;
import '../../features/fill_profile/view/view_models/fill_profile_view_model.dart'
    as _i471;
import '../../features/home/view/view_model/home_screen_view_model.dart'
    as _i736;
import '../../features/profile_tab/data/data_source/profile_tab_data_source.dart'
    as _i583;
import '../../features/profile_tab/data/data_source_impl/profile_tab_data_source_impl.dart'
    as _i583;
import '../../features/profile_tab/data/repository_impl/profile_tab_repository_impl.dart'
    as _i937;
import '../../features/profile_tab/domain/repository/profile_tab_repository.dart'
    as _i888;
import '../../features/profile_tab/domain/usecases/get_user_data_usecase.dart'
    as _i583;
import '../../features/profile_tab/view/view_model/profile_tab_view_model.dart'
    as _i825;
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
    gh.factory<_i736.HomeScreenViewModel>(() => _i736.HomeScreenViewModel());
    gh.singleton<_i254.SharedPreferencesHelper>(
        () => _i254.SharedPreferencesHelper());
    gh.factory<_i364.AuthDataSource>(() => _i105.AuthDataSourceImpl());
    gh.factory<_i583.ProfileTabDataSource>(
        () => _i583.ProfileTabDataSourceImpl());
    gh.factory<_i760.FillProfileDataSource>(
        () => _i186.FillProfileDataSourceImpl());
    gh.factory<_i89.FillProfileRepository>(() =>
        _i325.FillProfileRepositoryImpl(gh<_i760.FillProfileDataSource>()));
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
    gh.factory<_i27.ForgetPasswordUsecase>(
        () => _i27.ForgetPasswordUsecase(gh<_i961.AuthRepository>()));
    gh.factory<_i888.ProfileTabRepository>(
        () => _i937.ProfileTabRepositoryImpl(gh<_i583.ProfileTabDataSource>()));
    gh.factory<_i49.FillProfileDataUsecase>(
        () => _i49.FillProfileDataUsecase(gh<_i89.FillProfileRepository>()));
    gh.factory<_i471.FillProfileViewModel>(
        () => _i471.FillProfileViewModel(gh<_i49.FillProfileDataUsecase>()));
    gh.factory<_i615.SignInViewModel>(() => _i615.SignInViewModel(
          gh<_i780.SignInWithEmailAndPasswordUsecase>(),
          gh<_i952.SignInWithFacebookUsecase>(),
          gh<_i645.SignInWithGoogleUsecase>(),
        ));
    gh.factory<_i247.ForgetPasswordViewModel>(
        () => _i247.ForgetPasswordViewModel(gh<_i27.ForgetPasswordUsecase>()));
    gh.factory<_i195.SignUpViewModel>(() => _i195.SignUpViewModel(
          gh<_i217.SignUpWithEmailAndPasswordUsecase>(),
          gh<_i645.SignInWithGoogleUsecase>(),
          gh<_i952.SignInWithFacebookUsecase>(),
          gh<_i3.VerifyAccountUsecase>(),
        ));
    gh.factory<_i583.GetUserDataUsecase>(
        () => _i583.GetUserDataUsecase(gh<_i888.ProfileTabRepository>()));
    gh.factory<_i825.ProfileTabViewModel>(
        () => _i825.ProfileTabViewModel(gh<_i583.GetUserDataUsecase>()));
    return this;
  }
}
