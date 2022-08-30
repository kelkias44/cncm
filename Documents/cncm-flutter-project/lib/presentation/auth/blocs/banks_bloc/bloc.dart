import 'package:bloc/bloc.dart';

import '../../../../data/repositories/department_repository.dart';
import 'event.dart';
import 'state.dart';

class BanksBloc extends Bloc<BanksEvent, BanksState> {
  DepartmentRepository departmentRepository;

  BanksBloc(this.departmentRepository) : super(InitialState()) {
    on<BanksEvent>((event, emit) async {
      if (event is LoadBanks) {
        emit(LoadingBanks());
        var banks = await departmentRepository.getBanks();
        banks.fold((error) => emit(ErrorGettingBanks(error)),
                (banks) async {
              print('banks: loaded from bloc');
              emit(LoadedBanks(banks.results.banks));
            });
      }
    });
  }
}
