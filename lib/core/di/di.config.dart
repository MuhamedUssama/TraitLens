// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/ai_chat/data/data_source/chat_data_source.dart' as _i582;
import '../../features/ai_chat/data/data_source_impl/chat_data_source_impl.dart'
    as _i922;
import '../../features/ai_chat/data/repository_impl/chat_repository_impl.dart'
    as _i654;
import '../../features/ai_chat/domain/repositoory/chat_repository.dart'
    as _i414;
import '../../features/ai_chat/domain/usecases/get_gemini_response.dart'
    as _i945;
import '../../features/ai_chat/view/view_model/chat_screen_view_model.dart'
    as _i158;
import '../../features/ai_detection/data/data_source/ai_detection_data_source.dart'
    as _i647;
import '../../features/ai_detection/data/data_source_impl/ai_detection_data_source_impl.dart'
    as _i32;
import '../../features/ai_detection/data/repository_impl/ai_detection_repository_impl.dart'
    as _i548;
import '../../features/ai_detection/domain/repository/ai_detection_repository.dart'
    as _i33;
import '../../features/ai_detection/domain/usecases/send_text_usecase.dart'
    as _i509;
import '../../features/ai_detection/view/view_models/text_view_model/text_detection_view_model.dart'
    as _i307;
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
import '../../features/profile_tab/domain/usecases/sign_out_usecase.dart'
    as _i882;
import '../../features/profile_tab/domain/usecases/update_user_data_usecase.dart'
    as _i154;
import '../../features/profile_tab/view/view_model/edit_profile_screen/edit_profile_screen_view_model.dart'
    as _i1016;
import '../../features/profile_tab/view/view_model/profile_tab/profile_tab_view_model.dart'
    as _i260;
import '../cache/shared_preferences.dart' as _i254;
import '../modules/dio_module.dart' as _i948;
import '../shared/language_view_model/language_view_model.dart' as _i100;

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
    final dioModule = _$DioModule();
    gh.factory<_i100.LanguageViewModel>(() => _i100.LanguageViewModel());
    gh.factory<_i736.HomeScreenViewModel>(() => _i736.HomeScreenViewModel());
    gh.singleton<_i254.SharedPreferencesHelper>(
        () => _i254.SharedPreferencesHelper());
    gh.lazySingleton<_i361.Dio>(() => dioModule.provideDio());
    gh.lazySingleton<_i647.AiDetectionDataSource>(
        () => _i32.AiDetectionDataSourceImpl(gh<_i361.Dio>()));
    gh.factory<_i33.AiDetectionRepository>(() =>
        _i548.AiDetectionRepositoryImpl(gh<_i647.AiDetectionDataSource>()));
    gh.factory<_i509.SendTextUsecase>(
        () => _i509.SendTextUsecase(gh<_i33.AiDetectionRepository>()));
    gh.factory<_i364.AuthDataSource>(() => _i105.AuthDataSourceImpl());
    gh.singleton<_i582.ChatDataSource>(() => _i922.ChatDataSourceImpl());
    gh.factory<_i583.ProfileTabDataSource>(
        () => _i583.ProfileTabDataSourceImpl());
    gh.factory<_i760.FillProfileDataSource>(
        () => _i186.FillProfileDataSourceImpl());
    gh.factory<_i414.ChatRepository>(
        () => _i654.ChatRepositoryImpl(gh<_i582.ChatDataSource>()));
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
    gh.factory<_i307.TextDetectionViewModel>(
        () => _i307.TextDetectionViewModel(gh<_i509.SendTextUsecase>()));
    gh.factory<_i49.FillProfileDataUsecase>(
        () => _i49.FillProfileDataUsecase(gh<_i89.FillProfileRepository>()));
    gh.factory<_i945.GetGeminiResponse>(
        () => _i945.GetGeminiResponse(gh<_i414.ChatRepository>()));
    gh.factory<_i158.ChatScreenViewModel>(
        () => _i158.ChatScreenViewModel(gh<_i945.GetGeminiResponse>()));
    gh.factory<_i882.SignOutUsecase>(
        () => _i882.SignOutUsecase(gh<_i888.ProfileTabRepository>()));
    gh.factory<_i154.UpdateUserDataUsecase>(
        () => _i154.UpdateUserDataUsecase(gh<_i888.ProfileTabRepository>()));
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
    gh.factory<_i1016.EditProfileScreenViewModel>(() =>
        _i1016.EditProfileScreenViewModel(gh<_i154.UpdateUserDataUsecase>()));
    gh.factory<_i583.GetUserDataUsecase>(
        () => _i583.GetUserDataUsecase(gh<_i888.ProfileTabRepository>()));
    gh.factory<_i260.ProfileTabViewModel>(() => _i260.ProfileTabViewModel(
          gh<_i583.GetUserDataUsecase>(),
          gh<_i882.SignOutUsecase>(),
        ));
    return this;
  }
}

class _$DioModule extends _i948.DioModule {}
