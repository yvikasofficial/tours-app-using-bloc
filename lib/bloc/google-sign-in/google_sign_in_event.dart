part of 'google_sign_in_bloc.dart';

@immutable
abstract class GoogleSignInEvent {}

class AppStartedEvent extends GoogleSignInEvent {}

class SignInUserEvent extends GoogleSignInEvent {}

class SignOutUserEvent extends GoogleSignInEvent {}
