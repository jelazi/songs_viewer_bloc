// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_page_bloc.dart';

class HomePageState extends Equatable {
  final String selectedSongId;
  final List<Song> listSong;
  final bool isEditIconVisible;
  final List<String> listExpandedSongs;

  const HomePageState({
    required this.selectedSongId,
    required this.listSong,
    required this.listExpandedSongs,
    required this.isEditIconVisible,
  });

  @override
  List<Object> get props => [selectedSongId, listSong, listExpandedSongs, isEditIconVisible];

  HomePageState copyWith({
    String? selectedSongId,
    List<Song>? listSong,
    bool? isEditIconVisible,
    List<String>? listExpandedSongs,
  }) {
    return HomePageState(
      selectedSongId: selectedSongId ?? this.selectedSongId,
      listSong: listSong ?? this.listSong,
      isEditIconVisible: isEditIconVisible ?? this.isEditIconVisible,
      listExpandedSongs: listExpandedSongs ?? this.listExpandedSongs,
    );
  }
}

class HomePageInitial extends HomePageState {
  const HomePageInitial({
    required super.isEditIconVisible,
    required super.selectedSongId,
    required super.listSong,
    required super.listExpandedSongs,
  });
}
