// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:default_project/services/enums.dart';
import 'package:default_project/view/pages/edit_pages/edit_chords.dart';
import 'package:default_project/view/widgets/dialogs/dialogs_export.dart';
import 'package:default_project/view/widgets/dialogs/question_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:default_project/services/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../blocs/export_blocs.dart';

class EditPage extends StatefulWidget {
  const EditPage({
    Key? key,
  }) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditSongBloc, EditSongState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            return _onWillPop(state);
          },
          child: Scaffold(appBar: AppBar(
            title: BlocBuilder<EditSongBloc, EditSongState>(
              builder: (context, state) {
                return Text(
                  '${'editSong'.tr()} ${state.currentEditSong.title}',
                  style: h5TextStyle.copyWith(color: Colors.white),
                );
              },
            ),
          ), body: BlocBuilder<EditSongBloc, EditSongState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EditRow(
                        typeValue: 'title'.tr(),
                        title: state.currentEditSong.title,
                        titleTextStyle: h3TextStyle,
                        editFunction: () {
                          showDialog(
                              context: context,
                              builder: ((context) {
                                return EditTextDialog(
                                  okClick: (value) {
                                    context.read<EditSongBloc>().add(ChangeSongValue(nameValue: 'title', value: value));
                                  },
                                  title: 'editTitle'.tr(),
                                  value: state.currentEditSong.title,
                                );
                              }));
                        }),
                    EditRow(
                        typeValue: 'interpret'.tr(),
                        title: state.currentEditSong.interpret,
                        titleTextStyle: labelTextStyle,
                        editFunction: () {
                          showDialog(
                              context: context,
                              builder: ((context) {
                                return EditTextDialog(
                                  okClick: (value) {
                                    context.read<EditSongBloc>().add(ChangeSongValue(nameValue: 'interpret', value: value));
                                  },
                                  title: 'editInterpret'.tr(),
                                  value: state.currentEditSong.interpret ?? '',
                                );
                              }));
                        }),
                    EditRow(
                        typeValue: 'indexSongBook'.tr(),
                        title: (state.currentEditSong.indexSongBook?.toString()),
                        titleTextStyle: labelTextStyle,
                        editFunction: () {
                          showDialog(
                              context: context,
                              builder: ((context) {
                                return EditNumberDialog(
                                  okClick: (value) {
                                    context.read<EditSongBloc>().add(ChangeSongValue(nameValue: 'indexSongBook', value: value));
                                  },
                                  title: 'indexSongBook'.tr(),
                                  value: state.currentEditSong.indexSongBook ?? 0,
                                );
                              }));
                        }),
                    EditRow(
                        typeValue: 'text'.tr(),
                        title: state.currentEditSong.lyrics,
                        titleTextStyle: labelTextStyle,
                        maxLines: 5,
                        editFunction: () {
                          Navigator.of(context).pushNamed('/editLyricPage');
                        },
                        chordEditFunction: () {
                          context.read<EditSongBloc>().add(const UpdateListUniqueChords(typeLyric: TypeLyric.translate));
                          Navigator.of(context).pushNamed('/editChordsPage');
                        }),
                    getGroups(context, state),
                    getTags(context, state),
                    EditRow(
                        typeValue: 'originalText'.tr(),
                        title: state.currentEditSong.originalLyrics,
                        titleTextStyle: labelTextStyle,
                        maxLines: 5,
                        editFunction: () {
                          Navigator.of(context).pushNamed('/editOriginalLyricPage');
                        },
                        chordEditFunction: () {
                          context.read<EditSongBloc>().add(const UpdateListUniqueChords(typeLyric: TypeLyric.original));
                          Navigator.of(context).pushNamed('/editOriginalChordsPage');
                        }),
                    getSheets(context, state),
                  ],
                ),
              );
            },
          )),
        );
      },
    );
  }

  Future<bool> _onWillPop(EditSongState state) async {
    final oldSong = context.read<EditSongBloc>().songsRepository.getSongById(state.currentEditSong.id);
    final listModified = oldSong?.checkModifiedSong(state.currentEditSong, false) ?? [];
    if (listModified.isNotEmpty) {
      return (await showDialog(
              context: context,
              builder: (BuildContext context) {
                return QuestionDialog(
                  title: 'saveChanges'.tr(),
                  question: listModified.toString() + 'saveChangesQuestion'.tr(),
                  okClick: () {
                    context.read<HomePageBloc>().add(UpdateSong(song: state.currentEditSong));
                    Navigator.of(context).pop(true);
                  },
                  cancelClick: () {
                    Navigator.of(context).pop(true);
                  },
                );
              }) ??
          false);
    }
    return true;
  }

  Widget getTags(BuildContext context, EditSongState state) {
    bool isNotEmptyOrNull = state.currentEditSong.tags != null && state.currentEditSong.tags!.isNotEmpty;
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: isNotEmptyOrNull ? AppColor.primaryColor : AppColor.grey3Color)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${'tags'.tr()}:', style: labelTextStyle.copyWith(color: isNotEmptyOrNull ? AppColor.grey1Color : AppColor.grey2Color)),
              Row(
                mainAxisAlignment: isNotEmptyOrNull ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        height: 30,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(border: Border.all(color: AppColor.primaryColor), borderRadius: BorderRadius.circular(4), color: Colors.white),
                        child: const Center(child: Icon(Icons.add, color: AppColor.primaryColor))),
                  ),
                  isNotEmptyOrNull
                      ? Row(
                          children: state.currentEditSong.tags!
                              .map((e) => GestureDetector(
                                    onLongPress: () {},
                                    child: Container(
                                        height: 30,
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: AppColor.primaryColor), borderRadius: BorderRadius.circular(4), color: AppColor.primaryLightestColor),
                                        child: Text(e, style: labelTextStyle.copyWith(color: Colors.white))),
                                  ))
                              .toList(),
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ));
  }
}

Widget getSheets(BuildContext context, EditSongState state) {
  bool isNotEmptyOrNull = state.currentEditSong.sheets != null && state.currentEditSong.sheets!.isNotEmpty;
  return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: isNotEmptyOrNull ? AppColor.primaryColor : AppColor.grey3Color)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${'sheets'.tr()}:', style: labelTextStyle.copyWith(color: isNotEmptyOrNull ? AppColor.grey1Color : AppColor.grey2Color)),
            Row(
              mainAxisAlignment: isNotEmptyOrNull ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      height: 30,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(border: Border.all(color: AppColor.primaryColor), borderRadius: BorderRadius.circular(4), color: Colors.white),
                      child: const Center(child: Icon(Icons.add, color: AppColor.primaryColor))),
                ),
                isNotEmptyOrNull
                    ? Row(
                        children: state.currentEditSong.sheets!.map((e) => SizedBox(width: 100, height: 150, child: Image.file(File('sheets/$e')))).toList(),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ));
}

Widget getGroups(BuildContext context, EditSongState state) {
  bool isNotEmptyOrNull = state.currentEditSong.groups != null && state.currentEditSong.groups!.isNotEmpty;
  return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: isNotEmptyOrNull ? AppColor.primaryColor : AppColor.grey3Color)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${'groups'.tr()}:', style: labelTextStyle.copyWith(color: isNotEmptyOrNull ? AppColor.grey1Color : AppColor.grey2Color)),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      height: 30,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(border: Border.all(color: AppColor.primaryColor), borderRadius: BorderRadius.circular(4), color: Colors.white),
                      child: const Center(child: Icon(Icons.add, color: AppColor.primaryColor))),
                ),
                isNotEmptyOrNull
                    ? Row(
                        children: state.currentEditSong.groups!
                            .map((e) => GestureDetector(
                                  onLongPress: () {},
                                  child: Container(
                                      height: 30,
                                      margin: const EdgeInsets.all(5),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: AppColor.primaryColor), borderRadius: BorderRadius.circular(4), color: AppColor.primaryLightestColor),
                                      child: Text(e, style: labelTextStyle.copyWith(color: Colors.white))),
                                ))
                            .toList(),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ));
}

// ignore: must_be_immutable
class EditRow extends StatelessWidget {
  final String typeValue;
  final String? title;
  final Function editFunction;
  final Function? chordEditFunction;
  final TextStyle titleTextStyle;
  int maxLines = 3;

  EditRow({
    Key? key,
    required this.typeValue,
    required this.title,
    required this.editFunction,
    required this.titleTextStyle,
    this.chordEditFunction,
    this.maxLines = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: (title == null || title!.isEmpty) ? AppColor.grey3Color : AppColor.primaryColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$typeValue:', style: labelTextStyle.copyWith(color: (title == null || title!.isEmpty) ? AppColor.grey2Color : AppColor.grey1Color)),
          (title == null || title!.isEmpty)
              ? Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        editFunction();
                      },
                      child: Container(
                          height: 30,
                          width: 30,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(border: Border.all(color: AppColor.primaryColor), borderRadius: BorderRadius.circular(4), color: Colors.white),
                          child: const Center(child: Icon(Icons.add, color: AppColor.primaryColor))),
                    ),
                  ))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            title ?? '',
                            style: titleTextStyle,
                            softWrap: true,
                            maxLines: maxLines,
                          )),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: AppColor.primaryColor,
                                ),
                                child: const Icon(Icons.edit)),
                            onPressed: () => editFunction(),
                          ),
                        ),
                        if (chordEditFunction != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: AppColor.primaryColor,
                                  ),
                                  child: Icon(MdiIcons.guitarAcoustic)),
                              onPressed: () => chordEditFunction!(),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
