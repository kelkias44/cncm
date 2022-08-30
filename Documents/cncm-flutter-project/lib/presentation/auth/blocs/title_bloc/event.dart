import 'package:equatable/equatable.dart';

abstract class TitleEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTitles extends TitleEvent {}