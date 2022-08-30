import 'package:equatable/equatable.dart';


abstract class SearchedUserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSearchedUsers extends SearchedUserEvent {
  final String query;
  LoadSearchedUsers({required this.query});
}

