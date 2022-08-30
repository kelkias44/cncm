import 'package:equatable/equatable.dart';

import '../../../data/models/ErrorResponse.dart';
import '../../../data/models/UserSearchResponse.dart';

class SearchedUserState extends Equatable{
  @override
  List<Object?> get props => [];
}

class InitialState extends SearchedUserState {}

class LoadingSearchedUser extends SearchedUserState {}

class ErrorGettingSearchUser extends SearchedUserState {
  final ErrorResponse errorResponse;

  ErrorGettingSearchUser(this.errorResponse);

  @override
  List<Object?> get props => [errorResponse];
}

class LoadedSearchedUsers extends SearchedUserState {
  final UserSearchResults searchResults;

  LoadedSearchedUsers(this.searchResults);

  @override
  List<Object?> get props => [searchResults];
}
class LoadedAssetsEmpty extends SearchedUserState {

  final List<UserSearchResults> searchResults;

  LoadedAssetsEmpty(this.searchResults);

  @override
  List<Object?> get props => [searchResults];
}