import 'package:equatable/equatable.dart';

import '../../../../data/models/AssociationResponse.dart';
import '../../../../data/models/ErrorResponse.dart';

class AssociationState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends AssociationState {}

class LoadingAssociations extends AssociationState {}

class ErrorGettingAssociations extends AssociationState {
  final ErrorResponse errorResponse;

  ErrorGettingAssociations(this.errorResponse);
  @override
  List<Object> get props => [errorResponse];
}

class LoadedAssociations extends AssociationState {
  final List<Association> associations;
  LoadedAssociations(this.associations);

  @override
  List<Object> get props => [associations];
}
class EmptyAssociation extends AssociationState {}