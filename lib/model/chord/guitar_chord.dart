class GuitarChord {
  double leadingSpace;
  String chordText;
  int index;

  GuitarChord(this.leadingSpace, this.chordText, this.index);

  @override
  String toString() {
    return 'Chord(leadingSpace: $leadingSpace, chordText: $chordText)';
  }
}
