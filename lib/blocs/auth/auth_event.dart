part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthUsernameChanged extends AuthEvent {
  final String username;

  const AuthUsernameChanged(this.username);

  @override
  List<Object> get props => [username];
}

final class AuthPasswordChanged extends AuthEvent {
  final String password;

  const AuthPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

final class AuthDateChanged extends AuthEvent {
  final String date;

  const AuthDateChanged(this.date);

  @override
  List<Object> get props => [date];
}

final class AuthNumberChanged extends AuthEvent {
  final String number;

  const AuthNumberChanged(this.number);

  @override
  List<Object> get props => [number];
}

final class AuthImageChanged extends AuthEvent {
  final List<int> image;

  const AuthImageChanged(this.image);
}

final class AuthFormSubmitted extends AuthEvent {
  const AuthFormSubmitted();
}
