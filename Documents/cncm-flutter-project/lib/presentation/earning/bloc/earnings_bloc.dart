import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:cncm_flutter_new/data/models/ErrorResponse.dart';
import 'package:cncm_flutter_new/data/models/earning_response.dart';
import 'package:cncm_flutter_new/data/repositories/earning_repository.dart';

part 'earnings_event.dart';
part 'earnings_state.dart';

class EarningsBloc extends Bloc<EarningsEvent, EarningsState> {
  EarningRepository earningRepository;
  EarningsBloc(
    this.earningRepository,
  ) : super(EarningsInitial()) {
    on<EarningOnLoad>((event, emit) async {
      emit(EarningsLoading());
      var earningData = await earningRepository.getEarningData();
      print('get the chart data');
      earningData.fold((error) => emit(ErrorGettingEarningsData(error)),
       (earningData) async => emit(EarningsLoaded(earningData.results)));      

      earningData.fold((error) => emit(ErrorGettingEarningsData(error)),
       (earningData) => emit(EarningsLoaded(earningData.results)));
    });
  }
}
