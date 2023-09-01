import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../model/song/song.dart';
import '../../repositories/settings_repository.dart';
import '../../services/enums.dart';

part 'preview_chord_event.dart';
part 'preview_chord_state.dart';

class PreviewChordBloc extends Bloc<PreviewChordEvent, PreviewChordState> {
  SettingsRepository settingsRepository;

  PreviewChordBloc({
    required this.settingsRepository,
  }) : super(PreviewChordInitial(
          data: CurrentData(song: null),
          textStyle: const TextStyle(),
          chordStyle: const TextStyle(),
          twoColumns: false,
          transposeIncrement: 0,
          scrollSpeed: 20,
          currentColumn: 0,
          maxLines: 20,
          appBarStatus: true,
        )) {
    on<_Init>(_init);
    on<ChangeCurrentSong>(_changeCurrentSong);
    on<ChangeTextFontSize>(_changeTextFontSize);
    on<ChangeChordFontSize>(_changeChordFontSize);
    on<ChangeAppBarStatus>(_changeAppBarStatus);

    add(const _Init());
  }

  void _init(_Init event, Emitter<PreviewChordState> emit) {
    final state = this.state;
    emit(state.copyWith(
        textStyle: TextStyle(fontSize: settingsRepository.fontTextSize, color: settingsRepository.colorText),
        chordStyle: TextStyle(fontSize: settingsRepository.fontChordSize, color: settingsRepository.colorChord)));
  }

  void _changeCurrentSong(ChangeCurrentSong event, Emitter<PreviewChordState> emit) {
    final state = this.state;
    emit(state.copyWith(data: state.data.copyWith(song: event.song)));
  }

  void _changeTextFontSize(ChangeTextFontSize event, Emitter<PreviewChordState> emit) {
    final state = this.state;
    settingsRepository.changeSettingsValue('fontTextSize', event.fontSize);
    emit(state.copyWith(textStyle: state.textStyle.copyWith(fontSize: event.fontSize)));
  }

  void _changeChordFontSize(ChangeChordFontSize event, Emitter<PreviewChordState> emit) {
    final state = this.state;
    settingsRepository.changeSettingsValue('fontChordSize', event.fontSize);
    emit(state.copyWith(textStyle: state.chordStyle.copyWith(fontSize: event.fontSize)));
  }

  void _changeAppBarStatus(ChangeAppBarStatus event, Emitter<PreviewChordState> emit) {
    final state = this.state;
    emit(state.copyWith(appBarStatus: event.status));
  }
}
