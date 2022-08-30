import 'package:equatable/equatable.dart';

abstract class DepartmentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadDepartments extends DepartmentEvent {}