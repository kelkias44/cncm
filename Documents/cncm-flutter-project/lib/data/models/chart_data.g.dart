// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartResult _$ChartResultFromJson(Map<String, dynamic> json) => ChartResult(
      amount: json['amount'] as int,
      date: json['date'].toString() as String,
    );

Map<String, dynamic> _$ChartResultToJson(ChartResult instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'date': instance.date,
    };

ChartData _$ChartDataFromJson(Map<String, dynamic> json) => ChartData(
      message: json['message'] as String,
      error: json['error'] as bool,
      code: json['code'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => ChartResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChartDataToJson(ChartData instance) => <String, dynamic>{
      'message': instance.message,
      'error': instance.error,
      'code': instance.code,
      'results': instance.results,
    };
