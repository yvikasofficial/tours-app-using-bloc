part of 'user_bloc.dart';

@immutable
abstract class UserState {
  final bool isLoading;
  UserState({this.isLoading = false});
}

class UserInitial extends UserState {}

class LoadingUserState extends UserState {
  LoadingUserState() : super(isLoading: true);
}

class ToursUserState extends UserState {
  final List<Tour> tours;
  ToursUserState({this.tours});
}

class ErrorUserState extends UserState {
  final String err;
  ErrorUserState({this.err});
}
