import 'package:default_project/view/desktop_view/pages/desktop_home_page/home_bodies/edit_parts_body/edit_lyrics.dart';
import 'package:flutter/material.dart';

import '../../../../../../blocs/export_blocs.dart';
import '../list_song.dart';

class EditBody extends StatefulWidget {
  const EditBody({super.key});

  @override
  State<EditBody> createState() => _EditBodyState();
}

class _EditBodyState extends State<EditBody> {
  final TextEditingController _filter = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        return Row(
          children: [
            const ListSong(),
            BlocBuilder<DesktopRibbonMenuBloc, DesktopRibbonMenuState>(
              builder: (context, state) {
                return Expanded(child: state.bodyEditName == 'lyrics' ? const EditLyricsBody() : Container());
              },
            )
          ],
        );
      },
    );
  }
}
