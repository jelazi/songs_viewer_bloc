import 'package:default_project/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../blocs/export_blocs.dart';
import '../../services/enums.dart';
import '../widgets/chords_lyric/flutter_chord.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        context.read<PreviewChordBloc>().add(const ChangeAppBarStatus(status: false));
      }
      if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
        context.read<PreviewChordBloc>().add(const ChangeAppBarStatus(status: true));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: BlocBuilder<PreviewChordBloc, PreviewChordState>(
          builder: (context, state) {
            return AnimatedContainer(
                height: state.appBarStatus ? 90.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: AppBar(
                  backgroundColor: AppColor.primaryColor,
                  title: Column(
                    children: [
                      Text(state.data.song?.title ?? '', style: h4TextStyle.copyWith(color: Colors.white)),
                      Text(state.data.song?.interpret ?? '', style: pTextStyle.copyWith(color: Colors.white))
                    ],
                  ),
                  actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
                ));
          },
        ),
      ),
      body: BlocBuilder<PreviewChordBloc, PreviewChordState>(
        builder: (context, state) {
          return _getLyricsRenderer(state, scrollController);
        },
      ),
    );
  }

  Widget _getLyricsRenderer(PreviewChordState state, ScrollController scrollController) {
    String lyric = state.data.song?.lyrics ?? '';
    List<String> list = lyric.split('\n');
    //TODO: controller.notes.value = List.generate(list.length + 1, (index) => RxString(''));
    if (state.twoColumns) {
      List<String> splittedLyric = state.lyricWithColumns(true, true, TypeLyric.translate);
      //TODO:  controller.maxColumns.value = splittedLyric.length;

      if (splittedLyric.length == 1) {
        return LyricsRenderer(
          scrollController: scrollController,
          lyrics: splittedLyric[0],
          textStyle: state.textStyle,
          chordStyle: state.chordStyle,
          onTapChord: (Chord chord, Offset pos) {
            //TODO:  controller.openChordImage(chord, pos);
          },
          transposeIncrement: state.transposeIncrement,
          scrollSpeed: state.scrollSpeed,
          isVisibleNote: true,
          baseFontSize: state.textStyle.fontSize ?? 20,
        );
      } else {
        int firstIndex = 0;
        if (state.currentColumn > 0) {
          for (String partSong in splittedLyric) {
            if (splittedLyric.indexOf(partSong) < state.currentColumn) {
              List<String> listLines = partSong.split('\n');
              firstIndex += listLines.length - 1;
            }
          }
        }
        int secondIndex = 0;
        if (state.currentColumn + 1 > 0) {
          for (String partSong in splittedLyric) {
            if (splittedLyric.indexOf(partSong) < state.currentColumn + 1) {
              List<String> listLines = partSong.split('\n');
              secondIndex += listLines.length - 1;
            }
          }
        }
        return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Flexible(
            child: LyricsRenderer(
              scrollController: scrollController,
              isVisibleNote: true,
              lyrics: splittedLyric[state.currentColumn],
              textStyle: state.textStyle,
              chordStyle: state.chordStyle,
              onTapChord: (Chord chord, Offset pos) {
                //TODO:    controller.openChordImage(chord, pos);
              },
              transposeIncrement: state.transposeIncrement,
              scrollSpeed: state.scrollSpeed,
              listNotes: state.data.song?.notes ?? [],
              startIndex: firstIndex,
              baseFontSize: state.textStyle.fontSize ?? 20,
            ),
          ),
          const VerticalDivider(
            color: Colors.blue,
          ),
          splittedLyric.length > state.currentColumn + 1
              ? Flexible(
                  child: LyricsRenderer(
                    scrollController: scrollController,
                    isVisibleNote: true,
                    lyrics: splittedLyric[state.currentColumn + 1],
                    textStyle: state.textStyle,
                    chordStyle: state.chordStyle,
                    onTapChord: (Chord chord, Offset pos) {
                      //TODO:   controller.openChordImage(chord, pos);
                    },
                    transposeIncrement: state.transposeIncrement,
                    scrollSpeed: state.scrollSpeed,
                    startIndex: secondIndex,
                    baseFontSize: state.textStyle.fontSize ?? 20,
                  ),
                )
              : Container(),
        ]);
      }
    } else {
      //TODO: state.maxColumns.value = 0;
      return LyricsRenderer(
        scrollController: scrollController,
        isVisibleNote: true,
        lyrics: lyric,
        textStyle: state.textStyle,
        chordStyle: state.chordStyle,
        onTapChord: (Chord chord, Offset pos) {
          //TODO:   controller.openChordImage(chord, pos);
        },
        transposeIncrement: state.transposeIncrement,
        scrollSpeed: state.scrollSpeed,
        baseFontSize: state.textStyle.fontSize ?? 20,
      );
    }
  }
}
