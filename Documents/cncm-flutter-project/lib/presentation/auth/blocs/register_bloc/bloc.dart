import 'package:bloc/bloc.dart';
import '../../../../core/util/local_storage_service.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../service_locator.dart';
import 'event.dart';
import 'state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc(this.authRepository) : super(InitialState()) {
    on<RegisterEvent>((event, emit) async {
      if (event is RegisterUser) {
        emit(LoadingRegister());
        var authData = await authRepository.register(
            registerRequest: event.registerRequest);
        authData.fold((error) {
          if(error.errors.fieldErrors.isNotEmpty){
            emit(FieldErrorRegister(error));
          }
          else {
            emit(ErrorRegister(error));
          }
        },
            (registerResponse) async {
              print('register response from right return: $registerResponse');
              Map<String, dynamic>  response =  registerResponse.toJson() ;
              emit(RegisteredState(registerResponse.results));
              await sl<LocalStorageService>().save('user', response['results']);
              await sl<LocalStorageService>().saveBooleanToDisk("login", true);
              await sl<LocalStorageService>().saveStringToDisk("token", registerResponse.results.token);
              await sl<LocalStorageService>().saveStringToDisk("name", registerResponse.results.firstName + ' ' + registerResponse.results.middleName + ' ' + registerResponse.results.lastName);

              print('register response from right return: $registerResponse');

        });
      }
    });

    // on<NoInternetEvent>((event, emit) {
    //   emit(AuthNoInternetState());
    // });
  }
}
