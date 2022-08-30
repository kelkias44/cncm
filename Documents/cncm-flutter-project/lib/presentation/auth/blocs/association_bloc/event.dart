import 'package:equatable/equatable.dart';
abstract class AssociationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class LoadAssociation extends AssociationEvent {
  final String associationId;
  LoadAssociation({required this.associationId});
}