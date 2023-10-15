// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final SettingsProperties settingsProperties;
  const SettingsState(this.settingsProperties);

  @override
  List<Object> get props => [settingsProperties];

  SettingsState copyWith({
    SettingsProperties? settingsProperties,
  }) {
    return SettingsState(
      settingsProperties ?? this.settingsProperties,
    );
  }
}

class SettingsInitial extends SettingsState {
  const SettingsInitial(super.settingsProperties);
}

class SettingsProperties {
  final double fontTextSize;
  final double fontChordSize;
  final Color colorText;
  final Color colorChord;
  final bool isEditIconVisible;
  SettingsProperties({
    required this.fontTextSize,
    required this.fontChordSize,
    required this.colorText,
    required this.colorChord,
    required this.isEditIconVisible,
  });

  SettingsProperties copyWith({
    double? fontTextSize,
    double? fontChordSize,
    Color? colorText,
    Color? colorChord,
    bool? isEditIconVisible,
  }) {
    return SettingsProperties(
      fontTextSize: fontTextSize ?? this.fontTextSize,
      fontChordSize: fontChordSize ?? this.fontChordSize,
      colorText: colorText ?? this.colorText,
      colorChord: colorChord ?? this.colorChord,
      isEditIconVisible: isEditIconVisible ?? this.isEditIconVisible,
    );
  }
}
