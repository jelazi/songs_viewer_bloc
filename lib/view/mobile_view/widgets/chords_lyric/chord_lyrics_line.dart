class ChordLyricsLine {
  List<Chord> chords;
  String lyrics;
  int index;

  ChordLyricsLine(this.index, this.chords, this.lyrics);

  @override
  String toString() {
    return 'ChordLyricsLine($chords, lyrics: $lyrics)';
  }
}

class Chord {
  double leadingSpace;
  String chordText;
  int index;

  Chord(this.leadingSpace, this.chordText, this.index);

  @override
  String toString() {
    return 'Chord(leadingSpace: $leadingSpace, chordText: $chordText)';
  }
}
