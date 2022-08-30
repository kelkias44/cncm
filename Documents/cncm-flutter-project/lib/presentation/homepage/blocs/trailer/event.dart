import 'package:equatable/equatable.dart';

abstract class TrailerEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class LoadTrailerEvent extends TrailerEvent {}
