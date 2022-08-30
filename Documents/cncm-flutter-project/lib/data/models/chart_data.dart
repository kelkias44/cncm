import 'package:json_annotation/json_annotation.dart';

part 'chart_data.g.dart';

@JsonSerializable()
class ChartResult{
  @JsonKey(name: 'amount')
  int amount;

  @JsonKey(name: 'date')
  String date;
  ChartResult({
    required this.amount,
    required this.date,
  });

  factory ChartResult.fromJson(Map<String, dynamic> json) => _$ChartResultFromJson(json);
  Map<String, dynamic> toJson() => _$ChartResultToJson(this);
}




@JsonSerializable()
class ChartData {
  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'error')
  bool error;

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'results')
  List<ChartResult> results;

  ChartData({
    required this.message,
    required this.error,
    required this.code,
    required this.results,
  });


  factory ChartData.fromJson(Map<String, dynamic> json) => _$ChartDataFromJson(json);
  Map<String, dynamic> toJson() => _$ChartDataToJson(this);
}
