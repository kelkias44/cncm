import 'package:bloc/bloc.dart';
import 'package:cncm_flutter_new/data/repositories/department_repository.dart';

import 'event.dart';
import 'state.dart';

class DepartmentBloc extends Bloc<DepartmentEvent, DepartmentState> {
  DepartmentRepository departmentRepository;

  DepartmentBloc(this.departmentRepository) : super(InitialState()) {
    on<DepartmentEvent>((event, emit) async {
      if (event is LoadDepartments) {
        emit(LoadingDepartments());
        var departments = await departmentRepository.getDepartments();
        departments.fold((error) => emit(ErrorGettingDepartments(error)),
            (departments) async {
          print('departments: loaded from bloc');
          print(departments);
          emit(LoadedDepartments(departments.results.departments));
        });
      }
    });
  }
}
