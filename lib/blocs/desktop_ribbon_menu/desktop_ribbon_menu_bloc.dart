import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'desktop_ribbon_menu_event.dart';
part 'desktop_ribbon_menu_state.dart';

class DesktopRibbonMenuBloc extends Bloc<DesktopRibbonMenuEvent, DesktopRibbonMenuState> {
  DesktopRibbonMenuBloc() : super(const DesktopRibbonMenuInitial(bodyHomeName: 'preview', bodyEditName: 'lyrics')) {
    on<ChangeHomeBody>(_changeHomeBody);
    on<ChangeEditBody>(_changeEditBody);
  }

  void _changeHomeBody(ChangeHomeBody event, Emitter<DesktopRibbonMenuState> emit) {
    emit(state.copyWith(bodyHomeName: event.bodyName));
  }

  void _changeEditBody(ChangeEditBody event, Emitter<DesktopRibbonMenuState> emit) {
    emit(state.copyWith(bodyEditName: event.bodyName));
  }
}
