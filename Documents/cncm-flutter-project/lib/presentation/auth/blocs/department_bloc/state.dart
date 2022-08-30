import 'package:equatable/equatable.dart';

import '../../../../data/models/AssetResponse.dart';
import '../../../../data/models/DepartmentResponse.dart';
import '../../../../data/models/ErrorResponse.dart';

class DepartmentState extends Equatable{
  @override
  List<Object?> get props => [];
}

class InitialState extends DepartmentState {}

class LoadingDepartments extends DepartmentState {}

class ErrorGettingDepartments extends DepartmentState {
  final ErrorResponse errorResponse;

  ErrorGettingDepartments(this.errorResponse);

  @override
  List<Object?> get props => [errorResponse];
}

class LoadedDepartments extends DepartmentState {
  final List<Department> departments;

  LoadedDepartments(this.departments);

  @override
  List<Object?> get props => [departments];
}
class LoadedDepartmentEmpty extends DepartmentState {
  final List<Department> departments;

  LoadedDepartmentEmpty(this.departments);

  @override
  List<Object?> get props => [departments];
}