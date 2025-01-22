part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;

  SignUpEvent(this.email, this.password);
}

class LogoutEvent extends AuthEvent {}


// for splash event

abstract class SplashEvent{}

class NavigateToLoginEvent extends SplashEvent {}

class NavigateToDashboardEvent extends SplashEvent {}
