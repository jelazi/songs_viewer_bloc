// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:default_project/repositories/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsRepository settingsRepository;
  SettingsBloc({
    required this.settingsRepository,
  }) : super(SettingsInitial(SettingsProperties(fontTextSize: 20, fontChordSize: 20, colorText: Colors.black, colorChord: Colors.red, isEditIconVisible: false))) {
    on<_SettingsInitial>(_settingsInitial);
    on<ChangeSettingsValue>(_changeSettingsValue);

    add(_SettingsInitial());
  }

  void _settingsInitial(_SettingsInitial event, Emitter<SettingsState> emit) {
    final state = this.state;
    emit(state.copyWith(
        settingsProperties: SettingsProperties(
      fontTextSize: settingsRepository.fontTextSize,
      fontChordSize: settingsRepository.fontChordSize,
      colorText: settingsRepository.colorText,
      colorChord: settingsRepository.colorChord,
      isEditIconVisible: settingsRepository.isEditIconVisible,
    )));
  }

  void _changeSettingsValue(ChangeSettingsValue event, Emitter<SettingsState> emit) {
    final state = this.state;
    settingsRepository.changeSettingsValue(event.typeValue, event.value);
    emit(state.copyWith(
        settingsProperties: state.settingsProperties.copyWith(
      fontTextSize: settingsRepository.fontTextSize,
      fontChordSize: settingsRepository.fontChordSize,
      colorText: settingsRepository.colorText,
      colorChord: settingsRepository.colorChord,
      isEditIconVisible: settingsRepository.isEditIconVisible,
    )));
  }
}
