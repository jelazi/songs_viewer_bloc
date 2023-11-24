// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:default_project/model/user.dart';
import 'package:default_project/repositories/settings_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:default_project/repositories/songs_repository.dart';

import '../../model/song/song.dart';
import '../../repositories/user_repository.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  SongsRepository songsRepository;
  SettingsRepository settingsRepository;
  UsersRepository usersRepository;

  HomePageBloc({
    required this.songsRepository,
    required this.settingsRepository,
    required this.usersRepository,
  }) : super(const HomePageInitial(
          selectedSongId: '',
          isEditIconVisible: false,
          listSong: [],
          listExpandedSongs: [],
          typeUser: TypeUser.none,
        )) {
    on<_Init>(_init);
    on<FilterSong>(_filterSong);
    on<ChangeSelectedSong>(_changeSelectedSong);
    on<SelectSong>(_selectSong);
    on<UpdateSettingsData>(_updateSettingsData);
    on<ChangeExpandedCard>(_changeExpandedCard);
    on<UpdateSong>(_updateSong);
    on<LoginUser>(_loginUser);
    songsRepository.selectSongData.listen((event) {
      add(ChangeSelectedSong(selectedSongId: event));
    });

    usersRepository.selectSongData.listen((event) {
      add(LoginUser(typeUser: event));
    });

    add(const _Init());
  }

  void _init(_Init event, Emitter<HomePageState> emit) {
    final state = this.state;

    emit(state.copyWith(
      isEditIconVisible: settingsRepository.isEditIconVisible,
      listSong: List<Song>.from(songsRepository.songs),
      selectedSongId: songsRepository.selectedSongId,
      listExpandedSongs: [],
    ));
  }

  void _updateSettingsData(UpdateSettingsData event, Emitter<HomePageState> emit) {
    final state = this.state;
    emit(state.copyWith(
      isEditIconVisible: settingsRepository.isEditIconVisible,
    ));
  }

  void _filterSong(FilterSong event, Emitter<HomePageState> emit) {
    final state = this.state;
    emit(state.copyWith(listSong: songsRepository.getSongByFilter(event.filter)));
  }

  void _changeSelectedSong(ChangeSelectedSong event, Emitter<HomePageState> emit) {
    final state = this.state;
    emit(state.copyWith(selectedSongId: event.selectedSongId));
  }

  void _selectSong(SelectSong event, Emitter<HomePageState> emit) {
    songsRepository.selectSong(event.selectedSongId);
  }

  void _changeExpandedCard(ChangeExpandedCard event, Emitter<HomePageState> emit) {
    final state = this.state;
    final oldListExpandedSongs = List<String>.from(state.listExpandedSongs);
    var listExpandedSongs = <String>[];
    if (oldListExpandedSongs.contains(event.songId)) {
    } else {
      listExpandedSongs.add(event.songId);
    }
    emit(state.copyWith(listExpandedSongs: listExpandedSongs));
  }

  void _updateSong(UpdateSong event, Emitter<HomePageState> emit) async {
    final state = this.state;
    await songsRepository.updateSong(event.song);
    emit(state.copyWith(listSong: List<Song>.from(songsRepository.songs)));
  }

  void _loginUser(LoginUser event, Emitter<HomePageState> emit) {
    final state = this.state;
    emit(state.copyWith(typeUser: event.typeUser));
  }
}
