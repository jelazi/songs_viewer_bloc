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
  }) : super(const SettingsInitial(
          previewFontTextSize: 20,
          previewFontChordSize: 20,
          editFontTextSize: 20,
          editFontChordSize: 20,
          previewColorText: Colors.black,
          previewColorChord: Colors.red,
          editColorText: Colors.black,
          editColorChord: Colors.red,
          isEditIconVisible: false,
          autoHideTopBar: false,
        )) {
    on<_SettingsInitial>(_settingsInitial);
    on<ChangeSettingsValue>(_changeSettingsValue);

    add(_SettingsInitial());
  }

  void _settingsInitial(_SettingsInitial event, Emitter<SettingsState> emit) {
    final state = this.state;
    _emitAllValues(state, emit);
  }

  void _changeSettingsValue(ChangeSettingsValue event, Emitter<SettingsState> emit) {
    final state = this.state;
    settingsRepository.changeSettingsValue(event.typeValue, event.value);
    _emitAllValues(state, emit);
  }

  void _emitAllValues(
    SettingsState state,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(
      previewFontTextSize: settingsRepository.previewFontTextSize,
      previewFontChordSize: settingsRepository.previewFontChordSize,
      previewColorText: settingsRepository.previewColorText,
      previewColorChord: settingsRepository.previewColorChord,
      editFontTextSize: settingsRepository.editFontTextSize,
      editFontChordSize: settingsRepository.editFontChordSize,
      editColorText: settingsRepository.editColorText,
      editColorChord: settingsRepository.editColorChord,
      isEditIconVisible: settingsRepository.isEditIconVisible,
      autoHideTopBar: settingsRepository.autoHideTopBar,
    ));
  }
}
