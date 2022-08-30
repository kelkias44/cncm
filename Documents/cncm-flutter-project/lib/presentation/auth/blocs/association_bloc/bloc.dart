import 'package:bloc/bloc.dart';
import 'package:cncm_flutter_new/data/repositories/department_repository.dart';

import 'event.dart';
import 'state.dart';

class AssociationBloc extends Bloc<AssociationEvent, AssociationState> {
  final DepartmentRepository departmentRepository;

  AssociationBloc(this.departmentRepository) : super(InitialState()) {
    on<AssociationEvent>((event, emit) async {
      if (event is LoadAssociation) {
        emit(LoadingAssociations());
        var associations =
            await departmentRepository.getAssociations(event.associationId);
        associations.fold((error) => emit(ErrorGettingAssociations(error)),
            (titles) async {
          if (titles.results.associationsData.associations.isEmpty) {
            emit(EmptyAssociation());
          } else {
            emit(LoadedAssociations(
                titles.results.associationsData.associations));
          }
        });
      }
    });
  }
}
