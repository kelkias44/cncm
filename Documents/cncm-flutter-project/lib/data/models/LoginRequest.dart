import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'LoginRequest.g.dart';
/** flutter pub run build_runner build */
@JsonSerializable()
class LoginRequest extends Equatable {
  LoginRequest({
    required this.username,
    required this.password,
  });

  String username;
  String password;
  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
