import 'package:default_project/view/widgets/settings_ui/settings_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../blocs/export_blocs.dart';
import '../widgets/settings_ui/settings_section.dart';
import '../widgets/settings_ui/settings_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
                      title: 'fontTextSize'.tr(),
                      onPressed: (BuildContext context) {
                        Navigator.of(context).pushNamed('/language');
                      },
                      iconData: Icons.font_download,
                      value: state.settingsProperties.fontTextSize,
                    ),
                    SettingsTile(
                      title: 'fontChordSize'.tr(),
                      onPressed: (BuildContext context) {
                        Navigator.of(context).pushNamed('/language');
                      },
                      iconData: Icons.font_download,
                      value: state.settingsProperties.fontChordSize,
                    ),
                    SettingsTile(
                      title: 'colorText'.tr(),
                      onPressed: (BuildContext context) {
                        Navigator.of(context).pushNamed('/language');
                      },
                      iconData: Icons.color_lens,
                      value: state.settingsProperties.colorText,
                      iconColor: state.settingsProperties.colorText,
                    ),
                    SettingsTile(
                      title: 'colorChord'.tr(),
                      onPressed: (BuildContext context) {
                        Navigator.of(context).pushNamed('/language');
                      },
                      iconData: Icons.color_lens,
                      value: state.settingsProperties.colorChord,
                      iconColor: state.settingsProperties.colorChord,
                    ),
                  ],
                ),
              ],
            );
          },
        ));
  }
}
