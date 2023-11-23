// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String username;
  final String password;
  final bool isLogin;
  const LoginState({
    required this.username,
    required this.password,
    required this.isLogin,
  });

  @override
  List<Object> get props => [username, password, isLogin];

  LoginState copyWith({
    String? username,
    String? password,
    bool? isLogin,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      isLogin: isLogin ?? this.isLogin,
    );
  }
}

class LoginInitial extends LoginState {
  const LoginInitial({required super.username, required super.password, required super.isLogin});
}
