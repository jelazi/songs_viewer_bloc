import 'package:default_project/blocs/export_blocs.dart';
import 'package:default_project/services/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../model/song/song.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Drawer(
        width: MediaQuery.of(context).size.width * 0.7,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: AppColor.primaryColor,
              ),
              child: Text(
                'songsViewer'.tr(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Row(children: [
                const Icon(Icons.add),
                const SizedBox(
                  width: 10,
                ),
                Text('addNewSong'.tr()),
              ]),
              onTap: () {
                Navigator.pop(context);
                context.read<EditSongBloc>().add(ChangeEditSong(song: Song.empty()));
                Navigator.pushNamed(context, '/editPage');
              },
            ),
            ListTile(
              title: Row(children: [
                const Icon(Icons.settings),
                const SizedBox(
                  width: 10,
                ),
                Text('settings'.tr()),
              ]),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settingsPage');
              },
            ),
          ],
        ),
      ),
    );
  }
}
