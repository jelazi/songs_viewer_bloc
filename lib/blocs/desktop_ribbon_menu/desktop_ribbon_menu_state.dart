// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'desktop_ribbon_menu_bloc.dart';

class DesktopRibbonMenuState extends Equatable {
  final String bodyHomeName;
  const DesktopRibbonMenuState({required this.bodyHomeName});

  @override
  List<Object> get props => [bodyHomeName];

  DesktopRibbonMenuState copyWith({
    String? bodyHomeName,
  }) {
    return DesktopRibbonMenuState(
      bodyHomeName: bodyHomeName ?? this.bodyHomeName,
    );
  }
}

class DesktopRibbonMenuInitial extends DesktopRibbonMenuState {
  const DesktopRibbonMenuInitial({required super.bodyHomeName});
}
