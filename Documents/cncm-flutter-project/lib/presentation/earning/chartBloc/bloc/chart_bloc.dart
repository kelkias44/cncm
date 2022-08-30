import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:cncm_flutter_new/data/models/ErrorResponse.dart';
import 'package:cncm_flutter_new/data/models/chart_data.dart';

import '../../../../data/repositories/chart_repository.dart';

part 'chart_event.dart';

part 'chart_state.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  ChartRepository chartRepository;

  ChartBloc(this.chartRepository) : super(ChartInitial()) {
    on<ChartEvent>((event, emit) async {
      if (event is ChartOnLoaded) {
        emit(ChartLoading());

        var charData = await chartRepository.getChartData(event.earningChartIndex);
        charData.fold((error) => emit(ErrorGettingChartData(error)),
                (chData){
              emit(ChartLoaded(chData.results));
                });

       
       } });

      
    } }

