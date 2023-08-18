class GuitarChordPattern {
  final List<String> tags;
  final List<String> names;

  List basePosition = [];

  GuitarChordPattern({
    required this.tags,
    required this.names,
    required String basePositionString,
  }) {
    _fillBasePosition(basePositionString);
  }

  bool containsFullName(String fullName) {
    for (String tag in tags) {
      for (String name in names) {
        String fulN = name + tag;
        if (fulN == fullName) {
          return true;
        }
      }
    }
    return false;
  }

  bool _isNumeric(String s) {
    // ignore: unnecessary_null_comparison
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  void _fillBasePosition(String basePositionString) {
    List<String> listPositions = basePositionString.split(' ');

    for (String stringPosition in listPositions) {
      dynamic position;
      if (_isNumeric(stringPosition)) {
        position = int.parse(stringPosition);
      }
      if (position is! int) {
        position = 'x';
      }
      basePosition.add(position);
    }
  }

  String getPositionByName(String fullName) {
    if (fullName.isEmpty || !containsFullName(fullName)) return '';
    String first = fullName[0];
    if (fullName.length > 1 && fullName[1] == '#') {
      first = '$first#';
    }
    int shift = names.indexOf(first);
    String patternToString = '';

    for (var i = 0; i < 6; i++) {
      if (basePosition[i] is int) {
        int newPosition = basePosition[i] + shift;
        patternToString += newPosition.toString();
      } else if (basePosition[i] as String == 'x') {
        patternToString += basePosition[i];
      }
      if (i < 5) {
        patternToString += " ";
      }
    }
    return patternToString;
  }
}
