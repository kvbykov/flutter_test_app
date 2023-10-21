import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:test_case/models/auth_models/models.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<AuthUsernameChanged>(_onUsernameChanged);
    on<AuthPasswordChanged>(_onPasswordChanged);
    on<AuthImageChanged>(_onProfileImageChanged);
    on<AuthDateChanged>(_onDateChanged);
    on<AuthNumberChanged>(_onNumberChanged);
    on<AuthFormSubmitted>(_onFormSubmitted);
  }

  void _onUsernameChanged(
    AuthUsernameChanged event,
    Emitter<AuthState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
          username: username,
          isValid: Formz.validate([
            username,
            state.password,
            state.profileImage,
            state.number,
            state.date,
          ])),
    );
  }

  void _onPasswordChanged(
    AuthPasswordChanged event,
    Emitter<AuthState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
          password: password,
          isValid: Formz.validate([
            password,
            state.username,
            state.number,
            state.profileImage,
            state.date,
          ])),
    );
  }

  void _onProfileImageChanged(
    AuthImageChanged event,
    Emitter<AuthState> emit,
  ) {
    final profileImage = ProfileImage.dirty(event.image);
    emit(
      state.copyWith(
          profileImage: profileImage,
          isValid: Formz.validate([
            profileImage,
            state.number,
            state.username,
            state.password,
            state.date,
          ])),
    );
  }

  void _onDateChanged(
    AuthDateChanged event,
    Emitter<AuthState> emit,
  ) {
    final date = Date.dirty(event.date);

    emit(
      state.copyWith(
        date: date,
        isValid: Formz.validate([
          date,
          state.number,
          state.username,
          state.password,
          state.profileImage,
        ]),
      ),
    );
  }

  void _onNumberChanged(
    AuthNumberChanged event,
    Emitter<AuthState> emit,
  ) {
    final number = Number.dirty(event.number);
    emit(
      state.copyWith(
        number: number,
        isValid: Formz.validate([
          number,
          state.date,
          state.username,
          state.password,
          state.profileImage,
        ]),
      ),
    );
  }

  Future<void> _onFormSubmitted(
    AuthFormSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(status: FormzSubmissionStatus.success));
  }
}
