// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'desktop_ribbon_menu_bloc.dart';

class DesktopRibbonMenuState extends Equatable {
  final String bodyHomeName;
  final String bodyEditName;
  const DesktopRibbonMenuState({required this.bodyHomeName, required this.bodyEditName});

  @override
  List<Object> get props => [bodyHomeName, bodyEditName];

  DesktopRibbonMenuState copyWith({
    String? bodyHomeName,
    String? bodyEditName,
  }) {
    return DesktopRibbonMenuState(
      bodyHomeName: bodyHomeName ?? this.bodyHomeName,
      bodyEditName: bodyEditName ?? this.bodyEditName,
    );
  }
}

class DesktopRibbonMenuInitial extends DesktopRibbonMenuState {
  const DesktopRibbonMenuInitial({required super.bodyHomeName, required super.bodyEditName});
}
