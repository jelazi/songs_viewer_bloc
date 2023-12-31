part of 'edit_song_bloc.dart';

class EditSongEvent extends Equatable {
  const EditSongEvent();

  @override
  List<Object> get props => [];
}

class _Init extends EditSongEvent {
  const _Init();

  @override
  List<Object> get props => [];
}

class ChangeEditSong extends EditSongEvent {
  final Song song;
  const ChangeEditSong({required this.song});
}

class ChangeSongValue extends EditSongEvent {
  final String value;
  final String nameValue;
  const ChangeSongValue({required this.value, required this.nameValue});
}

class CheckModifiedSong extends EditSongEvent {
  const CheckModifiedSong();
}

class ResetValue extends EditSongEvent {
  final String nameValue;
  const ResetValue({required this.nameValue});
  @override
  List<Object> get props => [nameValue];
}

class TransposeChordPermanent extends EditSongEvent {
  final int transposeIncrement;
  final bool isOriginalLyric;
  const TransposeChordPermanent({required this.transposeIncrement, required this.isOriginalLyric});
  @override
  List<Object> get props => [transposeIncrement, isOriginalLyric];
}

class ChangeFontSizeEdit extends EditSongEvent {
  final bool isIncrease;
  const ChangeFontSizeEdit({required this.isIncrease});

  @override
  List<Object> get props => [isIncrease];
}

class SelectChord extends EditSongEvent {
  final int index;
  const SelectChord({required this.index});

  @override
  List<Object> get props => [index];
}

class ChangeListUniqueChordsIsVisible extends EditSongEvent {
  final bool isVisible;
  const ChangeListUniqueChordsIsVisible({required this.isVisible});

  @override
  List<Object> get props => [isVisible];
}

class UpdateListUniqueChords extends EditSongEvent {
  final TypeLyric typeLyric;
  const UpdateListUniqueChords({required this.typeLyric});

  @override
  List<Object> get props => [typeLyric];
}
