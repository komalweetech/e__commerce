import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';

part 'auth_state.dart';

// for Splash Bloc

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {
    Future.delayed(const Duration(seconds: 5), () async {
      final prefs = await SharedPreferences.getInstance();
      final String? uid = prefs.getString('uid');

      if(uid != null){
        add(NavigateToDashboardEvent());
      }else {
        add(NavigateToLoginEvent());
      }
    });

    on<NavigateToLoginEvent>((event, emit) {
      emit(NavigateToLoginState());
    });
    on<NavigateToDashboardEvent>((event, emit) {
      emit(NavigateToDashboardState());
    });

  }
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthBloc(this._firebaseAuth) : super(AuthInitial()) {
    // for login state..
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
            email: event.email, password: event.password);

        final String? uid = userCredential.user?.uid;

// Save UID in SharedPreferences
        if(uid != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('uid', uid);
        }
        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    // for signup state..
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
      final UserCredential userCredential  = await _firebaseAuth.createUserWithEmailAndPassword(
            email: event.email, password: event.password);
      final String? uid = userCredential.user?.uid;

      // Save UID in SharedPreferences
      if(uid != null){
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('uid', uid);
      }
        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    // for logOut state..
    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await _firebaseAuth.signOut();

        // Clear UID from SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('uid');
        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
