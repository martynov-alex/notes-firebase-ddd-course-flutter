import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_firebase_ddd_course/domain/auth/i_auth_facade.dart';

part 'auth_event.dart';
part 'auth_state.dart';

part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthFacade _authFacade;

  AuthBloc(this._authFacade) : super(const AuthState.initial()) {
    on<AuthCheckRequested>(_performAuthCheckRequested);
    on<SignedOut>(_performSignedOut);
  }

  Future<void> _performAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final userOption = await _authFacade.getSignedInUser();
    emit(
      userOption.fold(
        () => const AuthState.unauthenticated(),
        (_) => const AuthState.authenticated(),
      ),
    );
  }

  void _performSignedOut(
    SignedOut event,
    Emitter<AuthState> emit,
  ) async {
    await _authFacade.signOut();
    emit(const AuthState.unauthenticated());
  }
}
