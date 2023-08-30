import 'chord_lyrics_line.dart';

class ChordLyricsDocument {
  final List<ChordLyricsLine> chordLyricsLines;

  ChordLyricsDocument(this.chordLyricsLines);

  Chord? getChordByIndex(int index) {
    for (ChordLyricsLine line in chordLyricsLines) {
      return line.chords.firstWhere((element) => element.index == index);
    }
    return null;
  }
}
