part of 'markallread_bloc.dart';

@immutable
abstract class MarkallreadState {}

class MarkallreadInitial extends MarkallreadState {}

class LoadingMarkallreadState extends MarkallreadState{}

class ErrorGettingMarkallreadState extends MarkallreadState{}

class LoadedMarkallreadState extends MarkallreadState {}
