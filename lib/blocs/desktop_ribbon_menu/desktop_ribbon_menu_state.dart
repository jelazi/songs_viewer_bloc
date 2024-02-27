// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'desktop_ribbon_menu_bloc.dart';

class DesktopRibbonMenuState extends Equatable {
  final String bodyName;
  final String bodyEditName;
  final bool isSelectedSong;
  const DesktopRibbonMenuState({
    required this.bodyName,
    required this.bodyEditName,
    required this.isSelectedSong,
  });

  @override
  List<Object> get props => [bodyName, bodyEditName, isSelectedSong];

  DesktopRibbonMenuState copyWith({
    String? bodyName,
    String? bodyEditName,
    bool? isSelectedSong,
  }) {
    return DesktopRibbonMenuState(
      bodyName: bodyName ?? this.bodyName,
      bodyEditName: bodyEditName ?? this.bodyEditName,
      isSelectedSong: isSelectedSong ?? this.isSelectedSong,
    );
  }
}

class DesktopRibbonMenuInitial extends DesktopRibbonMenuState {
  const DesktopRibbonMenuInitial({required super.bodyName, required super.bodyEditName, required super.isSelectedSong});
}
