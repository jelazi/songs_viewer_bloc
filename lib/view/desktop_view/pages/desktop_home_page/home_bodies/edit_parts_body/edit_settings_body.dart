import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../blocs/export_blocs.dart';
import '../../../../../../services/constants.dart';

class EditSettingsBody extends StatefulWidget {
  const EditSettingsBody({super.key});

  @override
  State<EditSettingsBody> createState() => _EditSettingsBodyState();
}

class _EditSettingsBodyState extends State<EditSettingsBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditSongBloc, EditSongState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width - 300,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(state.currentEditSong.title, style: const TextStyle(fontSize: 15)),
                    SizedBox(
                      width: 320,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                                onTap: () {
                                  context.read<EditSongBloc>().add(const SaveSong());
                                },
                                child: Container(
                                    height: 30,
                                    width: 150,
                                    margin: const EdgeInsets.only(left: 5, right: 5),
                                    decoration: BoxDecoration(
                                      color: state.isOriginalLyrics
                                          ? state.currentText == state.currentEditSong.originalLyrics
                                              ? AppColor.defaultBackgroundColor
                                              : AppColor.primaryColor
                                          : state.currentText == state.currentEditSong.lyrics
                                              ? AppColor.defaultBackgroundColor
                                              : AppColor.primaryColor,
                                      border: Border.all(color: AppColor.grey1Color),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(child: Text('save'.tr())))),
                          )
                        ],
                      ),
                    )
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('groups'.tr(), style: const TextStyle(fontSize: 15)),
                const SizedBox(width: 10),
                ...(state.listAllGroups)
                    .map((group) => MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              context.read<EditSongBloc>().add(ChangeGroupForCurrentSong(group: group));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 5),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: state.currentGroups.contains(group) ? AppColor.defaultBackgroundColor : Colors.white,
                                border: Border.all(color: AppColor.grey1Color),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Row(
                                children: [
                                  Text(group, style: const TextStyle(fontSize: 12)),
                                  const SizedBox(width: 5),
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ],
            )
          ],
        );
      },
    );
  }
}
