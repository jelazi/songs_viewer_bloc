import 'package:bloc/bloc.dart';
import 'package:default_project/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UsersRepository usersRepository;

  LoginBloc({required this.usersRepository})
      : super(const LoginInitial(
          username: '',
          password: '',
          isLogin: false,
        )) {
    on<Login>(_login);
    on<Logout>(_logout);
  }

  void _login(Login event, Emitter<LoginState> emit) {
    final state = this.state;
    final isLogin = usersRepository.checkUser(event.username, event.password);
    if (isLogin) {
      emit(state.copyWith(username: event.username, password: event.password, isLogin: isLogin));
    } else {
      emit(state.copyWith(username: '', password: '', isLogin: isLogin));
    }
  }

  void _logout(Logout event, Emitter<LoginState> emit) {
    final state = this.state;
    emit(state.copyWith(username: '', password: ''));
  }
}
