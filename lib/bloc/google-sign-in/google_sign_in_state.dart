part of 'google_sign_in_bloc.dart';

@immutable
abstract class GoogleSignInState {
  GoogleSignInState({this.isLoading = false});
  final bool isLoading;
}

class GoogleSignInLoadingState extends GoogleSignInState {
  GoogleSignInLoadingState() : super(isLoading: true);
}

class GoogleAuthState extends GoogleSignInState {}

class GoogleSignInFailedState extends GoogleSignInState {
  final String error;
  GoogleSignInFailedState({this.error});
}

class GoogleUnAuthState extends GoogleSignInState {}
