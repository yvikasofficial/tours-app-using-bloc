import 'package:firebase_auth/firebase_auth.dart';
import 'package:tours_app/providers/authentication_provider.dart';

class AuthenticationRepository {
  final AuthenticationProvider _authenticationProvider =
      AuthenticationProvider();

  Future<User> signInWithGmail() => _authenticationProvider.singInWithGmail();

  Future<void> signOut() => _authenticationProvider.signOut();

  User get currentUser => _authenticationProvider.currentUser;
}
