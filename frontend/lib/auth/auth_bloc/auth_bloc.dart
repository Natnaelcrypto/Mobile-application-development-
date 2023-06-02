import 'package:flutter_bloc/flutter_bloc.dart';

import '../../user/model/user_model.dart';
import '../auth_repository/information_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthLoading()) {
    on<AuthLogin>(
      (event, emit) async {
        print(event.auth.userName);
        emit(AuthLoading());
        try {
          User user = await authRepository.login(event.auth);
          emit(AuthDataLoaded(user));
        } catch (error) {
          emit(AuthDataLoadingError(error));
        }
      },
    );

    on<AuthSignup>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          final user = await authRepository.signup(event.user);
          emit(AuthDataLoaded(user));
        } catch (error) {
          emit(AuthDataLoadingError(error));
        }
      },
    );
  }
}
