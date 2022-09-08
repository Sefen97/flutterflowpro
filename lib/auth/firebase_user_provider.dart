import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class LoginScreenFirebaseUser {
  LoginScreenFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

LoginScreenFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<LoginScreenFirebaseUser> loginScreenFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<LoginScreenFirebaseUser>(
        (user) => currentUser = LoginScreenFirebaseUser(user));
