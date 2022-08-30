import 'package:bloc/bloc.dart';
import 'package:cncm_flutter_new/data/repositories/asset_resoisitory.dart';


import 'event.dart';
import 'state.dart';




class RegisterAssetBloc extends Bloc<RegisterAssetEvent, RegisterAssetState> {
  final AssetRepository assetRepository;

  RegisterAssetBloc(this.assetRepository) : super(InitialState()) {
    on<RegisterAssetEvent>((event, emit) async {
      if (event is RegisterAsset) {
        emit(LoadingRegisterAsset());
        var assetData = await assetRepository.postAssets(
            asset: event.assetRegistrationRequest);
        assetData.fold((error) {
          if(error.errors.fieldErrors.isNotEmpty){
            emit(FieldErrorRegisterAsset(error));
          }
          else {
            emit(ErrorRegisterAsset(error));
          }
        }, (registerResponse) async {
              emit(RegisteredAssetState());
            });
      }
    });
  }
}
