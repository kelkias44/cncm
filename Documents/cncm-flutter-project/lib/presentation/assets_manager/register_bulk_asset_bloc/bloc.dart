import 'package:bloc/bloc.dart';
import 'package:cncm_flutter_new/data/repositories/asset_resoisitory.dart';


import 'event.dart';
import 'state.dart';




class RegisterBulkAssetBloc extends Bloc<RegisterBulkAssetEvent, RegisterBulkAssetState> {
  final AssetRepository assetRepository;

  RegisterBulkAssetBloc(this.assetRepository) : super(InitialState()) {
    on<RegisterBulkAssetEvent>((event, emit) async {
      if (event is RegisterBulkAsset) {
        emit(LoadingRegisterBulkAsset());
        var assetData = await assetRepository.postBulkAssets(
            asset: event.assetRegistrationRequest);
        assetData.fold((error) {
          if(error.errors.fieldErrors.isNotEmpty){
            emit(FieldErrorRegisterBulkAsset(error));
          }
          else {
            emit(ErrorRegisterBulkAsset(error));
          }
        }, (registerResponse) async {
              emit(RegisteredBulkAssetState());
            });
      }
    });
  }
}
