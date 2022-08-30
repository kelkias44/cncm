import 'package:bloc/bloc.dart';
import 'package:cncm_flutter_new/data/repositories/asset_resoisitory.dart';

import 'event.dart';
import 'state.dart';


class AssetManageBloc extends Bloc<AssetManageEvent, AssetManageState> {
  AssetRepository assetRepository;

  AssetManageBloc(this.assetRepository) : super(InitialState()) {

    on<AssetManageEvent>((event, emit) async {
      if (event is LoadAssets) {
        emit(LoadingAssets());
        var assets = await assetRepository.getAssets();
        print('assets: loading from bloc');
        assets.fold((error) => emit(ErrorGettingAssets(error)),
                (assetResponse) async {
              print('assets: loaded from bloc');
              print(assetResponse);
              emit(LoadedAssets(assetResponse.results!));
            });
      }
    });
  }
}
