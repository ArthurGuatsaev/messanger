import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:messanger/const/extension.dart';

class PlayerMessage extends StatefulWidget {
  final FlutterSoundPlayer myPlayer;
  final bool mine;
  final String audio;
  const PlayerMessage(
      {super.key,
      required this.mine,
      required this.myPlayer,
      required this.audio});

  @override
  State<PlayerMessage> createState() => _PlayerMessageState();
}

class _PlayerMessageState extends State<PlayerMessage> {
  @override
  void initState() {
    player.openPlayer();
    super.initState();
  }

  @override
  void dispose() {
    widget.myPlayer.closePlayer();
    widget.myPlayer.onProgress?.listen((event) {
      log('${event.position}');
    });
    super.dispose();
  }

  FlutterSoundPlayer player = FlutterSoundPlayer();

  Future<void> start() async {
    log('${widget.myPlayer.isPlaying}');
    await player.startPlayer(fromURI: widget.audio, codec: Codec.aacADTS);
    setState(() {});
  }

  Future<void> stop() async {
    await player.stopPlayer();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: context.color.chartBottom),
      margin: EdgeInsets.only(
          left: widget.mine ? 50 : 0, right: widget.mine ? 0 : 50, top: 10),
      padding: const EdgeInsets.all(8),
      child: Row(children: [
        GestureDetector(
            onTap: () async => !player.isPlaying ? start() : stop(),
            child:
                player.isPlaying ? Icon(Icons.stop) : Icon(Icons.play_arrow)),
        SizedBox(width: 5),
        Expanded(child: SizedBox()),
      ]),
    );
  }
}
