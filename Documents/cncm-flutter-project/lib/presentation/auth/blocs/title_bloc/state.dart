import 'package:equatable/equatable.dart';

import '../../../../data/models/ErrorResponse.dart';
import '../../../../data/models/TitlesResponse.dart';

class TitleState extends Equatable{
  @override
  List<Object?> get props => [];
}

class InitialState extends TitleState {}

class LoadingTitles extends TitleState {}

class ErrorGettingTitles extends TitleState {
  final ErrorResponse errorResponse;

  ErrorGettingTitles(this.errorResponse);

  @override
  List<Object?> get props => [errorResponse];
}

class LoadedTitles extends TitleState {
  final List<ContributorRole> titles;

  LoadedTitles(this.titles);

  @override
  List<Object?> get props => [titles];
}
class LoadedTitleEmpty extends TitleState {
  final List<ContributorRole> titles;

  LoadedTitleEmpty(this.titles);

  @override
  List<Object?> get props => [titles];
}