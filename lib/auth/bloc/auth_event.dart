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
  final String name;

  SignUpEvent({required this.email, required this.password, required this.name});
}

class LogoutEvent extends AuthEvent {}


// for splash event

abstract class SplashEvent{}

class NavigateToLoginEvent extends SplashEvent {}

class NavigateToDashboardEvent extends SplashEvent {}

class ForgotPasswordEvent extends AuthEvent {
  final String email;

  ForgotPasswordEvent(this.email);
}
