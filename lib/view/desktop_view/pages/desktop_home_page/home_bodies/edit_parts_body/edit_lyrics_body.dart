import 'package:flutter/material.dart';

import '../../../../../../blocs/export_blocs.dart';
import '../../../../../../services/constants.dart';

class EditLyricsBody extends StatefulWidget {
  const EditLyricsBody({super.key});

  @override
  State<EditLyricsBody> createState() => _EditLyricsBodyState();
}

class _EditLyricsBodyState extends State<EditLyricsBody> {
  final TextEditingController editingController = TextEditingController();
  bool isOriginalLyrics = false;

  @override
  void initState() {
    super.initState();
    editingController.text = context.read<EditSongBloc>().state.currentEditSong.lyrics;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditSongBloc, EditSongState>(
      listener: (context, state) {
        isOriginalLyrics = state.currentEditSong.originalLyrics != null && state.currentEditSong.originalLyrics != '';
        editingController.text = isOriginalLyrics ? state.currentEditSong.originalLyrics ?? '' : state.currentEditSong.lyrics;
      },
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Text(state.currentEditSong.title, style: const TextStyle(fontSize: 20)),
                  ],
                )),
            Expanded(
              child: SingleChildScrollView(
                  child: Container(
                padding: const EdgeInsets.only(left: 8),
                color: AppColor.defaultBackgroundColor,
                width: MediaQuery.of(context).size.width - 300,
                child: TextFormField(
                  controller: editingController,
                  style: TextStyle(fontSize: 13, color: state.textStyle.color),
                  maxLines: 200,
                  onChanged: (value) {
                    context.read<EditSongBloc>().add(ChangeSongValue(value: value, nameValue: isOriginalLyrics ? 'originalLyrics' : 'lyrics'));
                  },
                ),
              )),
            ),
          ],
        );
      },
    );
  }
}
