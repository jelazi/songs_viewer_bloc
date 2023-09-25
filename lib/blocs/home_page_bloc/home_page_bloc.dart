// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:default_project/repositories/songs_repository.dart';

import '../../model/song/song.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  SongsRepository songsRepository;

  HomePageBloc({
    required this.songsRepository,
  }) : super(HomePageInitial(homePageProperties: HomePageProperties(listSong: []))) {
    on<_Init>(_init);
    on<FilterSong>(_filterSong);

    add(const _Init());
  }

  void _init(_Init event, Emitter<HomePageState> emit) {
    final state = this.state;
    emit(state.copyWith(homePageProperties: HomePageProperties(listSong: songsRepository.songs)));
  }

  void _filterSong(FilterSong event, Emitter<HomePageState> emit) {
    final state = this.state;
    emit(state.copyWith(homePageProperties: state.homePageProperties.copyWith(listSong: songsRepository.getSongByFilter(event.filter))));
  }
}
