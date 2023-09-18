part of 'preview_chord_bloc.dart';

class PreviewChordEvent extends Equatable {
  const PreviewChordEvent();

  @override
  List<Object> get props => [];
}

class _Init extends PreviewChordEvent {
  const _Init();
}

class ChangeCurrentSong extends PreviewChordEvent {
  final Song? song;
  const ChangeCurrentSong({required this.song});

  @override
  List<Object> get props => [];
}

class ChangeTextFontSize extends PreviewChordEvent {
  final double fontSize;
  const ChangeTextFontSize({required this.fontSize});

  @override
  List<Object> get props => [fontSize];
}

class ChangeChordFontSize extends PreviewChordEvent {
  final double fontSize;
  const ChangeChordFontSize({required this.fontSize});

  @override
  List<Object> get props => [fontSize];
}

class ChangeFontSize extends PreviewChordEvent {
  final bool isIncrease;
  const ChangeFontSize({required this.isIncrease});

  @override
  List<Object> get props => [isIncrease];
}

class ChangeAppBarStatus extends PreviewChordEvent {
  final bool status;
  const ChangeAppBarStatus({required this.status});

  @override
  List<Object> get props => [status];
}

class ChangeVisibleButtons extends PreviewChordEvent {
  final bool status;
  const ChangeVisibleButtons({required this.status});

  @override
  List<Object> get props => [status];
}

class TransposeChord extends PreviewChordEvent {
  final int increment;
  const TransposeChord({required this.increment});

  @override
  List<Object> get props => [increment];
}
