part of 'settings_bloc.dart';

class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class _SettingsInitial extends SettingsEvent {}

class ChangeSettingsValue extends SettingsEvent {
  final String typeValue;
  final dynamic value;
  const ChangeSettingsValue(this.typeValue, this.value);
  @override
  List<Object> get props => [typeValue, value];
}
