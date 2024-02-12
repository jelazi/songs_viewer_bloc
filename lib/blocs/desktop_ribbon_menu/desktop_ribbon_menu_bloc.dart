import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'desktop_ribbon_menu_event.dart';
part 'desktop_ribbon_menu_state.dart';

class DesktopRibbonMenuBloc extends Bloc<DesktopRibbonMenuEvent, DesktopRibbonMenuState> {
  DesktopRibbonMenuBloc() : super(const DesktopRibbonMenuInitial(bodyHomeName: 'preview')) {
    on<ChangeHomeBody>(_changeHomeBody);
  }

  void _changeHomeBody(ChangeHomeBody event, Emitter<DesktopRibbonMenuState> emit) {
    emit(state.copyWith(bodyHomeName: event.bodyName));
  }
}
