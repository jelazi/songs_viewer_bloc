part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class Login extends LoginEvent {
  final String username;
  final String password;

  const Login({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class Logout extends LoginEvent {
  const Logout();
}
