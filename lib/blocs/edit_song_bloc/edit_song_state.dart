// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_song_bloc.dart';

class EditSongState extends Equatable {
  final Song currentEditSong;
  const EditSongState({
    required this.currentEditSong,
  });

  @override
  List<Object> get props => [currentEditSong];

  EditSongState copyWith({
    Song? currentEditSong,
  }) {
    return EditSongState(
      currentEditSong: currentEditSong ?? this.currentEditSong,
    );
  }
}

class EditSongInitial extends EditSongState {
  const EditSongInitial({required super.currentEditSong});
}
