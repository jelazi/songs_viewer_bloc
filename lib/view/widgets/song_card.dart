// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:f_logs/f_logs.dart';
import 'package:flutter/material.dart';

import '../../model/song/song.dart';
import '../../services/constants.dart';

class SongCard extends StatelessWidget {
  final Song song;
  const SongCard({
    Key? key,
    required this.song,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FLog.debug(text: 'clickCard');
      },
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: primaryColor),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(4),
          width: MediaQuery.of(context).size.width,
          height: 70,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      song.title,
                      style: h5TextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      song.interpret ?? '',
                      style: labelTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
