part of 'auth_bloc.dart';

final class AuthState extends Equatable {
  final FormzSubmissionStatus status;
  final Username username;
  final Password password;
  final ProfileImage profileImage;
  final Number number;
  final Date date;
  final bool isValid;

  const AuthState({
    this.status = FormzSubmissionStatus.initial,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.number = const Number.pure(),
    this.profileImage = const ProfileImage.pure(),
    this.date = const Date.pure(),
    this.isValid = false,
  });

  AuthState copyWith({
    FormzSubmissionStatus? status,
    Username? username,
    Password? password,
    ProfileImage? profileImage,
    Number? number,
    Date? date,
    bool? isValid,
  }) {
    return AuthState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      profileImage: profileImage ?? this.profileImage,
      number: number ?? this.number,
      isValid: isValid ?? this.isValid,
      date: date ?? this.date,
    );
  }

  @override
  List<Object> get props =>
      [status, username, password, profileImage, number, date];
}
