import 'package:default_project/view/widgets/settings_ui/settings_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../blocs/export_blocs.dart';
import '../widgets/settings_ui/settings_section.dart';
import '../widgets/settings_ui/settings_tile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('settings'.tr()),
        ),
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return SettingsList(
              sections: [
                SettingsSection(
                  title: 'general'.tr(),
                  tiles: [
                    SettingsTile(
                      title: 'previewFontTextSize'.tr(),
                      onPressed: (BuildContext context) {
                        Navigator.of(context).pushNamed('/language');
                      },
                      iconData: Icons.font_download,
                      value: state.previewFontTextSize,
                    ),
                    SettingsTile(
                      title: 'previewFontChordSize'.tr(),
                      onPressed: (BuildContext context) {
                        Navigator.of(context).pushNamed('/language');
                      },
                      iconData: Icons.font_download,
                      value: state.previewFontChordSize,
                    ),
                    SettingsTile(
                      title: 'editFontTextSize'.tr(),
                      onPressed: (BuildContext context) {
                        Navigator.of(context).pushNamed('/language');
                      },
                      iconData: Icons.font_download,
                      value: state.editFontTextSize,
                    ),
                    SettingsTile(
                      title: 'editFontChordSize'.tr(),
                      onPressed: (BuildContext context) {
                        Navigator.of(context).pushNamed('/language');
                      },
                      iconData: Icons.font_download,
                      value: state.editFontChordSize,
                    ),
                    SettingsTile(
                      title: 'previewColorText'.tr(),
                      onPressed: (BuildContext context) {
                        Navigator.of(context).pushNamed('/language');
                      },
                      iconData: Icons.color_lens,
                      value: state.previewColorText,
                      iconColor: state.previewColorText,
                    ),
                    SettingsTile(
                      title: 'previewColorChord'.tr(),
                      onPressed: (BuildContext context) {
                        Navigator.of(context).pushNamed('/language');
                      },
                      iconData: Icons.color_lens,
                      value: state.previewColorChord,
                      iconColor: state.previewColorChord,
                    ),
                    SettingsTile(
                      title: 'editColorText'.tr(),
                      onPressed: (BuildContext context) {
                        Navigator.of(context).pushNamed('/language');
                      },
                      iconData: Icons.color_lens,
                      value: state.editColorText,
                      iconColor: state.editColorText,
                    ),
                    SettingsTile(
                      title: 'editColorChord'.tr(),
                      onPressed: (BuildContext context) {
                        Navigator.of(context).pushNamed('/language');
                      },
                      iconData: Icons.color_lens,
                      value: state.editColorChord,
                      iconColor: state.editColorChord,
                    ),
                    SettingsTile.switched(
                      title: 'editIconVisibility'.tr(),
                      onPressed: (context, value) {
                        context.read<SettingsBloc>().add(ChangeSettingsValue('isEditIconVisible', value));
                      },
                      iconData: Icons.visibility,
                      switchValue: state.isEditIconVisible,
                    ),
                  ],
                ),
              ],
            );
          },
        ));
  }
}
