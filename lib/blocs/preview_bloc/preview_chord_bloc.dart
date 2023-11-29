import 'package:default_project/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          visibleButtons: false,
          cap: 0,
        )) {
    on<_Init>(_init);
    on<ChangeCurrentSong>(_changeCurrentSong);
    on<ChangeTextFontSize>(_changeTextFontSize);
    on<ChangeChordFontSize>(_changeChordFontSize);
    on<ChangeFontSize>(_changeFontSize);
    on<ChangeAppBarStatus>(_changeAppBarStatus);
    on<ChangeVisibleButtons>(_changeVisibleButtons);
    on<TransposeChord>(_transposeChord);
    add(const _Init());
  }

  void _init(_Init event, Emitter<PreviewChordState> emit) {
    final state = this.state;
    emit(state.copyWith(
        textStyle: TextStyle(fontSize: settingsRepository.previewFontTextSize, color: settingsRepository.previewColorText),
        chordStyle: TextStyle(fontSize: settingsRepository.previewFontChordSize, color: settingsRepository.previewColorChord)));
  }

  void _changeCurrentSong(ChangeCurrentSong event, Emitter<PreviewChordState> emit) {
    final state = this.state;
    final transposeIncrement = songsRepository.getTransposeForSong(event.song);

    if (state.textStyle.color != settingsRepository.previewColorText ||
        state.textStyle.fontSize != settingsRepository.previewFontTextSize ||
        state.chordStyle.color != settingsRepository.previewColorChord ||
        state.chordStyle.fontSize != settingsRepository.previewFontChordSize) {
      emit(state.copyWith(
        data: state.data.copyWith(song: event.song),
        textStyle: TextStyle(fontSize: settingsRepository.previewFontTextSize, color: settingsRepository.previewColorText),
        chordStyle: TextStyle(
          fontSize: settingsRepository.previewFontChordSize,
          color: settingsRepository.previewColorChord,
        ),
        transposeIncrement: transposeIncrement,
        cap: _getCapByIncrement(transposeIncrement),
      ));
    } else {
      emit(state.copyWith(data: state.data.copyWith(song: event.song), transposeIncrement: transposeIncrement, cap: _getCapByIncrement(transposeIncrement)));
    }
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
    if (settingsRepository.autoHideTopBar) {
      emit(state.copyWith(appBarStatus: event.status));
    } else {
      emit(state.copyWith(appBarStatus: true));
    }
  }

  void _changeVisibleButtons(ChangeVisibleButtons event, Emitter<PreviewChordState> emit) {
    final state = this.state;
    emit(state.copyWith(visibleButtons: event.status));
  }

  void _changeFontSize(ChangeFontSize event, Emitter<PreviewChordState> emit) {
    final state = this.state;
    double fontSize = state.textStyle.fontSize!;
    double chordSize = state.chordStyle.fontSize!;
    if (event.isIncrease) {
      fontSize++;
      chordSize++;
    } else {
      fontSize--;
      chordSize--;
    }
    settingsRepository.changeSettingsValue('fontTextSize', fontSize);
    settingsRepository.changeSettingsValue('fontChordSize', chordSize);
    emit(state.copyWith(textStyle: state.textStyle.copyWith(fontSize: fontSize), chordStyle: state.chordStyle.copyWith(fontSize: chordSize)));
  }

  void _transposeChord(TransposeChord event, Emitter<PreviewChordState> emit) {
    final state = this.state;
    int newIncrement = state.transposeIncrement + event.increment;
    if (newIncrement >= 12) {
      newIncrement = newIncrement - 12;
    }
    if (newIncrement <= -12) {
      newIncrement = newIncrement + 12;
    }

    songsRepository.changeTransposeChord(state.data.song, newIncrement);
    emit(state.copyWith(transposeIncrement: newIncrement, cap: _getCapByIncrement(newIncrement)));
  }

  int _getCapByIncrement(int increment) {
    int cap = 0;
    if (increment == 0) {
      cap = 0;
    } else {
      if (increment < 0) {
        cap = -1 * increment;
      } else {
        cap = 12 - increment;
      }
    }
    return cap;
  }
}
