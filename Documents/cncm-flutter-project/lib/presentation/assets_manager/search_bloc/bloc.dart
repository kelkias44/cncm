import 'package:bloc/bloc.dart';
import 'package:cncm_flutter_new/data/repositories/department_repository.dart';
import 'package:cncm_flutter_new/presentation/assets_manager/search_bloc/state.dart';

import 'event.dart';

class SearchedUserBloc extends Bloc<SearchedUserEvent, SearchedUserState> {
  DepartmentRepository departmentRepository;

  SearchedUserBloc(this.departmentRepository) : super(InitialState()) {

    on<SearchedUserEvent>((event, emit) async {
      if (event is LoadSearchedUsers) {
        emit(LoadingSearchedUser());
        var assets = await departmentRepository.searchUsers(event.query);

        assets.fold((error) => emit(ErrorGettingSearchUser(error)),
                (searchResponse) async {
              print('users search: loaded from bloc');
              print(searchResponse);
              emit(LoadedSearchedUsers(searchResponse.results));
            });
      }
    });
  }
}