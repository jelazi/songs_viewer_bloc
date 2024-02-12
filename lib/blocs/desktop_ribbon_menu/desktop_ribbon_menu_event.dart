part of 'desktop_ribbon_menu_bloc.dart';

class DesktopRibbonMenuEvent extends Equatable {
  const DesktopRibbonMenuEvent();

  @override
  List<Object> get props => [];
}

class ChangeHomeBody extends DesktopRibbonMenuEvent {
  final String bodyName;
  const ChangeHomeBody({required this.bodyName});
  @override
  List<Object> get props => [bodyName];
}
