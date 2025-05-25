import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 1));
//It depends on 3 main cases
      if (event.email.contains('@') && event.password.length >= 6) {
        emit(AuthSuccess());
      } else {
        emit(const AuthFailure('Invalid email or password'));
      }
    });

    on<AuthSignupRequested>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 1));

      if (event.email.contains('@') && event.password.length >= 6) {
        emit(AuthSuccess());
      } else {
        emit(const AuthFailure('Failed to sign up'));
      }
    });

    on<AuthLogoutRequested>((event, emit) {
      emit(AuthInitial());
    });
  }
}
