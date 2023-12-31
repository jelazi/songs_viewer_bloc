// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:default_project/model/user.dart';
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
  bool _autoHideTopBar = false;
  User _currentUser = User.empty();

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

  bool get autoHideTopBar {
    return _autoHideTopBar;
  }

  User get currentUser {
    return _currentUser;
  }

  Future<void> loadLocalSettings() async {
    _previewFontTextSize = await hiveProvider.getSettingsValue('previewFontTextSize') ?? 20;
    _previewFontChordSize = await hiveProvider.getSettingsValue('previewFontChordSize') ?? 20;
    _editFontTextSize = await hiveProvider.getSettingsValue('editFontTextSize') ?? 20;
    _editFontChordSize = await hiveProvider.getSettingsValue('editFontChordSize') ?? 20;
    _previewColorText = Color(await hiveProvider.getSettingsValue('previewColorText') ?? Colors.black.value);
    _previewColorChord = Color(await hiveProvider.getSettingsValue('previewColorChord') ?? Colors.red.value);
    _editColorText = Color(await hiveProvider.getSettingsValue('editColorText') ?? Colors.black.value);
    _editColorChord = Color(await hiveProvider.getSettingsValue('editColorChord') ?? Colors.red.value);
    _isEditIconVisible = await hiveProvider.getSettingsValue('isEditIconVisible') ?? true;
    _autoHideTopBar = await hiveProvider.getSettingsValue('autoHideTopBar') ?? false;
    _currentUser = await hiveProvider.getSettingsValue('currentUser') ?? User.empty();
  }

  void setCurrentUser(User user) {
    _currentUser = user;
    hiveProvider.setSettingsValue('currentUser', user);
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
          hiveProvider.setSettingsValue('previewColorText', value.value);
          break;
        }
      case 'previewColorChord':
        {
          _previewColorChord = value;
          hiveProvider.setSettingsValue('previewColorChord', value.value);
          break;
        }
      case 'editColorText':
        {
          _previewColorText = value;
          hiveProvider.setSettingsValue('editColorText', value.value);
          break;
        }
      case 'editColorChord':
        {
          _previewColorChord = value;
          hiveProvider.setSettingsValue('editColorChord', value.value);
          break;
        }
      case 'isEditIconVisible':
        {
          _isEditIconVisible = value;
          hiveProvider.setSettingsValue('isEditIconVisible', value);
          break;
        }
      case 'autoHideTopBar':
        {
          _autoHideTopBar = value;
          hiveProvider.setSettingsValue('autoHideTopBar', value);
          break;
        }
      case 'currentUser':
        {
          _currentUser = value;
          hiveProvider.setSettingsValue('currentUser', value);
          break;
        }
    }
  }
}
