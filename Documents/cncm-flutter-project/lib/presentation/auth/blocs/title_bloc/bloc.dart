import 'package:bloc/bloc.dart';

import '../../../../data/repositories/department_repository.dart';
import 'event.dart';
import 'state.dart';

class TitleBloc extends Bloc<TitleEvent, TitleState> {
  final DepartmentRepository departmentRepository;

  TitleBloc(this.departmentRepository) : super(InitialState()) {
    on<TitleEvent>((event, emit) async {
      if (event is LoadTitles) {
        emit(LoadingTitles());
        var newsFeeds = await departmentRepository.getTitles();
        newsFeeds.fold((error) => emit(ErrorGettingTitles(error)),
                (titles) async {
              emit(LoadedTitles(titles.results.contributorRoles));
            });
      }
    });
  }

}
