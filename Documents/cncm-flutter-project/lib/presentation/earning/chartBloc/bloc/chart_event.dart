part of 'chart_bloc.dart';

abstract class ChartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChartOnLoaded extends ChartEvent {
  int earningChartIndex;

  ChartOnLoaded({
    required this.earningChartIndex,
  });

  @override
  List<Object?> get props => [earningChartIndex];
}
