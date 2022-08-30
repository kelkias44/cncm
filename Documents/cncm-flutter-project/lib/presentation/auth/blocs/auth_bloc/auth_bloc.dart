import 'package:cncm_flutter_new/core/util/connectivity_service.dart';
import 'package:cncm_flutter_new/data/models/ErrorResponse.dart';
import 'package:cncm_flutter_new/data/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/local_storage_service.dart';
import '../../../../data/models/LoginRequest.dart';
import '../../../../data/models/LoginUser.dart';
import '../../../../service_locator.dart';
import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  // final ConnectivityService _connectivityService;

  AuthBloc(this.authRepository)
      : super(InitialState()) {
    // _connectivityService.connectivityStream.stream.listen((event) {
    //   if (event == ConnectivityResult.none) {
    //     print('no internet');
    //     add(NoInternetEvent());
    //   } else {
    //     print('has internet');
    //   }
    // });
    on<AuthEvent>((event, emit) async {
      if (event is SendAuthData) {
        emit(SendingAuthData());
          var authData = await authRepository.login(
              loginRequest: LoginRequest(
                  password: event.password, username: event.username));
          authData.fold(
              (error) => emit(ErrorSendingAuthData(error)),
              (loginResponse) async {
                print('loginResponse from right return: $loginResponse');
                Map<String, dynamic>  response =  loginResponse.toJson() ;
                emit(AuthenticatedState(loginResponse.results));
                ///saving user data's to local storage
                ///
                await sl<LocalStorageService>().saveStringToDisk("token", loginResponse.results.token);

                await sl<LocalStorageService>().saveStringToDisk("userId", loginResponse.results.id);

                await sl<LocalStorageService>().save('user', response['results']);
                await sl<LocalStorageService>().saveBooleanToDisk("login", true);

                await sl<LocalStorageService>().getToken;
                await sl<LocalStorageService>().getStringFromDisk('user');
                await sl<LocalStorageService>().saveStringToDisk("name", loginResponse.results.firstName + ' ' + loginResponse.results.middleName + ' ' + loginResponse.results.lastName);
          });
      }
      else if (event is CheckAuthOnStartUp) {
        emit(CheckingAuth());
        try {
          late User user;
          if (await sl<LocalStorageService>().isLogin("login")) {
            user = User.fromJson(await sl<LocalStorageService>().read('user'));
            emit(AuthenticatedState(user));
          } else {
            // emit(ErrorSendingAuthData(ErrorResponse())); TODO
          }
        } catch (e) {
          print('from exception: $e');
          debugPrint('$e');
          throw Exception(e);
        }
      }
    });

    on<NoInternetEvent>((event, emit) {
      emit(AuthNoInternetState());
    });
  }
}
