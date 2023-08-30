// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../services/enums.dart';

import 'chord_parser_pdf.dart';

class LyricsRendererPDF extends pw.StatelessWidget {
  final String lyrics;
  final pw.TextStyle textStyle;
  final pw.TextStyle chordStyle;
  final bool showChord;
  final BuildContext buildContext;

  final TypeTranspose typeTranspose;

  LyricsRendererPDF({
    required this.lyrics,
    required this.textStyle,
    required this.chordStyle,
    required this.buildContext,
    this.showChord = false,
    this.typeTranspose = TypeTranspose.czech,
  });

  List<String> superScripts = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '#',
  ];

  @override
  pw.Widget build(pw.Context context) {
    ChordProcessorPDF chordProcessor = ChordProcessorPDF(context);
    final chordLyricsDocument = chordProcessor.processText(
      text: lyrics,
      lyricsStyle: textStyle,
      chordStyle: chordStyle,
      context: buildContext,
    );
    if (chordLyricsDocument.chordLyricsLines.isEmpty) return pw.Container();
    return pw.ListView.separated(
      separatorBuilder: (context, index) => pw.SizedBox(height: 8),
      itemBuilder: (context, index) {
        final line = chordLyricsDocument.chordLyricsLines[index];
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              children: line.chords.map((chord) {
                if (superScripts.firstWhereOrNull((element) => chord.chordText.contains(element)) != null) {
                  List<String> list = chord.chordText.split('');

                  return pw.Row(
                    children: [
                      pw.SizedBox(
                        width: chord.leadingSpace,
                      ),
                      pw.RichText(
                        softWrap: true,
                        text: pw.TextSpan(
                          children: list.map((e) {
                            if (superScripts.contains(e)) {
                              return pw.WidgetSpan(
                                  child: pw.Transform.translate(
                                offset: PdfPoint(0, (chordStyle.fontSize! * 0.4)),
                                child: pw.Text(
                                  e,
                                  //superscript is usually smaller in size
                                  textScaleFactor: 0.6,
                                  style: chordStyle,
                                ),
                              ));
                            } else {
                              return pw.TextSpan(text: e, style: chordStyle);
                            }
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                } else {
                  return pw.Row(
                    children: [
                      pw.SizedBox(
                        width: chord.leadingSpace,
                      ),
                      pw.RichText(
                        softWrap: true,
                        text: pw.TextSpan(
                          text: chord.chordText,
                          style: chordStyle,
                        ),
                      ),
                    ],
                  );
                }
              }).toList(),
            ),
            pw.RichText(
              softWrap: true,
              text: pw.TextSpan(
                text: line.lyrics,
                style: textStyle,
              ),
            ),
          ],
        );
      },
      itemCount: chordLyricsDocument.chordLyricsLines.length,
    );
  }
}
