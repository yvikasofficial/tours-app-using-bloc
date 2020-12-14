import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tours_app/providers/authentication_provider.dart';

part 'google_sign_in_event.dart';
part 'google_sign_in_state.dart';

class GoogleSignInBloc extends Bloc<GoogleSignInEvent, GoogleSignInState> {
  GoogleSignInBloc() : super(GoogleSignInLoadingState());

  final AuthenticationProvider _authenticationProvider =
      AuthenticationProvider();
  @override
  Stream<GoogleSignInState> mapEventToState(
    GoogleSignInEvent event,
  ) async* {
    if (event is SignInUserEvent) {
      yield* _handleSignInUserEvent();
    } else if (event is SignOutUserEvent) {
      yield* _handleSignOutUserEvent();
    } else {
      yield* _handelAppLaunched();
    }
  }

  Stream<GoogleSignInState> _handleSignInUserEvent() async* {
    yield GoogleSignInLoadingState();
    try {
      await _authenticationProvider.singInWithGmail();
      yield GoogleAuthState();
    } catch (e) {
      yield GoogleSignInFailedState(error: "Unexpected Error Occured!");
    }
  }

  Stream<GoogleSignInState> _handleSignOutUserEvent() async* {
    yield GoogleSignInLoadingState();
    await _authenticationProvider.signOut();
    yield GoogleUnAuthState();
  }

  Stream<GoogleSignInState> _handelAppLaunched() async* {
    print(_authenticationProvider.currentUser);
    yield _authenticationProvider.currentUser == null
        ? GoogleUnAuthState()
        : GoogleAuthState();
  }
}
