// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:default_project/repositories/settings_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:default_project/repositories/songs_repository.dart';

import '../../model/song/song.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  SongsRepository songsRepository;
  SettingsRepository settingsRepository;

  HomePageBloc({
    required this.songsRepository,
    required this.settingsRepository,
  }) : super(HomePageInitial(
          homePageProperties: HomePageProperties(
            listSong: [],
            isEditIconVisible: true,
            listExpandedSongs: [],
          ),
        )) {
    on<_Init>(_init);
    on<FilterSong>(_filterSong);
    on<ChangeSelectedSong>(_changeSelectedSong);
    on<SelectSong>(_selectSong);
    on<UpdateSettingsData>(_updateSettingsData);
    on<ChangeExpandedCard>(_changeExpandedCard);
    songsRepository.selectSongData.listen((event) {
      add(ChangeSelectedSong(selectedSongId: event));
    });
    add(const _Init());
  }

  void _init(_Init event, Emitter<HomePageState> emit) {
    final state = this.state;

    emit(state.copyWith(
        homePageProperties: HomePageProperties(
      listSong: songsRepository.songs,
      selectedSongId: songsRepository.selectedSongId,
      isEditIconVisible: settingsRepository.isEditIconVisible,
      listExpandedSongs: [],
    )));
  }

  void _updateSettingsData(UpdateSettingsData event, Emitter<HomePageState> emit) {
    final state = this.state;
    emit(state.copyWith(
        homePageProperties: state.homePageProperties.copyWith(
      isEditIconVisible: settingsRepository.isEditIconVisible,
    )));
  }

  void _filterSong(FilterSong event, Emitter<HomePageState> emit) {
    final state = this.state;
    emit(state.copyWith(homePageProperties: state.homePageProperties.copyWith(listSong: songsRepository.getSongByFilter(event.filter))));
  }

  void _changeSelectedSong(ChangeSelectedSong event, Emitter<HomePageState> emit) {
    final state = this.state;
    emit(state.copyWith(homePageProperties: state.homePageProperties.copyWith(selectedSongId: event.selectedSongId)));
  }

  void _selectSong(SelectSong event, Emitter<HomePageState> emit) {
    songsRepository.selectSong(event.selectedSongId);
  }

  void _changeExpandedCard(ChangeExpandedCard event, Emitter<HomePageState> emit) {
    final state = this.state;
    final oldListExpandedSongs = state.homePageProperties.listExpandedSongs;
    var listExpandedSongs = <String>[];
    if (oldListExpandedSongs.contains(event.songId)) {
    } else {
      listExpandedSongs.add(event.songId);
    }
    emit(state.copyWith(homePageProperties: state.homePageProperties.copyWith(listExpandedSongs: listExpandedSongs)));
  }
}
