// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../providers/hive_provider.dart';

class SettingsRepository {
  HiveProvider hiveProvider;
  bool isLargeScreen = false;
  double _fontTextSize = 20;
  double _fontChordSize = 20;
  Color _colorText = Colors.black;
  Color _colorChord = Colors.red;
  SettingsRepository({
    required this.hiveProvider,
  });

  double get fontTextSize {
    return _fontTextSize;
  }

  double get fontChordSize {
    return _fontChordSize;
  }

  Color get colorText {
    return _colorText;
  }

  Color get colorChord {
    return _colorChord;
  }

  void changeSettingsValue(String typeValue, dynamic value) {
    switch (typeValue) {
      case 'fontTextSize':
        {
          _fontTextSize = value;
          hiveProvider.setSettingsValue('fontTextSize', value);
          break;
        }

      case 'fontChordSize':
        {
          _fontChordSize = value;
          hiveProvider.setSettingsValue('fontChordSize', value);
          break;
        }
      case 'colorText':
        {
          _colorText = value;
          hiveProvider.setSettingsValue('colorText', value);
          break;
        }
      case 'colorChord':
        {
          _colorChord = value;
          hiveProvider.setSettingsValue('colorChord', value);
          break;
        }
    }
  }
}
