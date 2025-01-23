part of 'auth_bloc.dart';

// for splash state
abstract class SplashState {}

class SplashInitialState extends SplashState {}

class NavigateToLoginState extends SplashState {}

class NavigateToDashboardState extends SplashState {}



// for login and signup state.
@immutable
sealed class AuthState {}

 class AuthInitial extends AuthState {}

 class AuthLoading extends AuthState {}

 class AuthAuthenticated extends AuthState {}

 class AuthUnauthenticated extends AuthState {}

 class AuthFailure extends AuthState {
 final String message;
 AuthFailure(this.message);
}

class PasswordResetEmailSent extends AuthState {}

