part of 'chart_bloc.dart';

abstract class ChartState extends Equatable {
  const ChartState();  

  @override
  List<Object?> get props => []; 
}

class ChartInitial extends ChartState {}
class ChartLoading extends ChartState{}

class ChartLoaded extends ChartState{
  final List<ChartResult> chartResults;

  const ChartLoaded(this.chartResults);

  @override
  List<Object?> get props => [chartResults];
}

class ErrorGettingChartData extends ChartState{
  final ErrorResponse errorResponse;

  const ErrorGettingChartData(this.errorResponse);

  @override
  List<Object?> get props => [errorResponse];
}


class ChartError extends ChartState{
  final String message;

  const ChartError(this.message);

  @override
  List<Object?> get props => [message];
}