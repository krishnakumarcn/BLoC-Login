part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
  });

  final Username username;
  final FormzStatus status;
  final Password password;

  LoginState copyWith({
    FormzStatus status,
    Username username,
    Password password,
  }) {
    return LoginState(
        status: status ?? this.status,
        username: username ?? this.username,
        password: password ?? this.password);
  }

  @override
  String toString() => """\n
  Username: ${username.value}
  Password: ${password.value}
  Status: $status
  """;

  @override
  List<Object> get props => [username, password, status];
}
