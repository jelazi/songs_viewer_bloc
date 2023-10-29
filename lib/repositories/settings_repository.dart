// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../providers/hive_provider.dart';

class SettingsRepository {
  HiveProvider hiveProvider;
  bool isLargeScreen = false;
  double _previewFontTextSize = 20;
  double _previewFontChordSize = 20;
  double _editFontTextSize = 20;
  double _editFontChordSize = 20;
  Color _previewColorText = Colors.black;
  Color _previewColorChord = Colors.red;
  Color _editColorText = Colors.black;
  Color _editColorChord = Colors.red;
  bool _isEditIconVisible = true;

  SettingsRepository({
    required this.hiveProvider,
  });

  double get previewFontTextSize {
    return _previewFontTextSize;
  }

  double get previewFontChordSize {
    return _previewFontChordSize;
  }

  double get editFontTextSize {
    return _editFontTextSize;
  }

  double get editFontChordSize {
    return _editFontChordSize;
  }

  Color get previewColorText {
    return _previewColorText;
  }

  Color get previewColorChord {
    return _previewColorChord;
  }

  Color get editColorText {
    return _editColorText;
  }

  Color get editColorChord {
    return _editColorChord;
  }

  bool get isEditIconVisible {
    return _isEditIconVisible;
  }

  Future<void> loadLocalSettings() async {
    _previewFontTextSize = await hiveProvider.getSettingsValue('previewFontTextSize') ?? 20;
    _previewFontChordSize = await hiveProvider.getSettingsValue('previewFontChordSize') ?? 20;
    _editFontTextSize = await hiveProvider.getSettingsValue('editFontTextSize') ?? 20;
    _editFontChordSize = await hiveProvider.getSettingsValue('editFontChordSize') ?? 20;
    _previewColorText = await hiveProvider.getSettingsValue('previewColorText') ?? Colors.black;
    _previewColorChord = await hiveProvider.getSettingsValue('previewColorChord') ?? Colors.red;
    _editColorText = await hiveProvider.getSettingsValue('editColorText') ?? Colors.black;
    _editColorChord = await hiveProvider.getSettingsValue('editColorChord') ?? Colors.red;
    _isEditIconVisible = await hiveProvider.getSettingsValue('isEditIconVisible') ?? true;
  }

  void changeSettingsValue(String typeValue, dynamic value) {
    switch (typeValue) {
      case 'previewFontTextSize':
        {
          _previewFontTextSize = value;
          hiveProvider.setSettingsValue('previewFontTextSize', value);
          break;
        }

      case 'previewFontChordSize':
        {
          _previewFontChordSize = value;
          hiveProvider.setSettingsValue('previewFontChordSize', value);
          break;
        }
      case 'editFontTextSize':
        {
          _previewFontTextSize = value;
          hiveProvider.setSettingsValue('editFontTextSize', value);
          break;
        }

      case 'editFontChordSize':
        {
          _previewFontChordSize = value;
          hiveProvider.setSettingsValue('editFontChordSize', value);
          break;
        }
      case 'previewColorText':
        {
          _previewColorText = value;
          hiveProvider.setSettingsValue('previewColorText', value);
          break;
        }
      case 'previewColorChord':
        {
          _previewColorChord = value;
          hiveProvider.setSettingsValue('previewColorChord', value);
          break;
        }
      case 'editColorText':
        {
          _previewColorText = value;
          hiveProvider.setSettingsValue('editColorText', value);
          break;
        }
      case 'editColorChord':
        {
          _previewColorChord = value;
          hiveProvider.setSettingsValue('editColorChord', value);
          break;
        }
      case 'isEditIconVisible':
        {
          _isEditIconVisible = value;
          hiveProvider.setSettingsValue('isEditIconVisible', value);
          break;
        }
    }
  }
}
