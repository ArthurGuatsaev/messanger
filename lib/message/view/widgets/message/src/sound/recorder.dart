import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:messanger/const/extension.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../domain/bloc/mess_bloc.dart';

class SoundRecorder extends StatefulWidget {
  final ValueNotifier<bool> notifier;
  const SoundRecorder({super.key, required this.notifier});

  @override
  State<SoundRecorder> createState() => _SoundRecorderState();
}

class _SoundRecorderState extends State<SoundRecorder> {
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  @override
  void initState() {
    initRecorder();
    super.initState();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      // throw 'Mickrophone permission not granted';
    }
    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future record() async {
    if (!isRecorderReady) return;
    await recorder.startRecorder(toFile: 'audio');
  }

  Future stop() async {
    if (!isRecorderReady) return;
    final mess = context.read<MessBloc>();
    final path = await recorder.stopRecorder();
    final audioFile = File(path!);
    mess.add(SendAudioEvent(file: audioFile));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessBloc, MessState>(
      builder: (context, state) {
        return GestureDetector(
          onLongPress: () async {
            await record();
            widget.notifier.value = true;
            setState(() {});
          },
          onLongPressEnd: (details) async {
            await stop();
            widget.notifier.value = false;
            setState(() {});
          },
          child: AnimatedContainer(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: context.color.chartBottom),
              duration: const Duration(milliseconds: 250),
              height: 42,
              width: recorder.isRecording
                  ? MediaQuery.of(context).size.width - 50
                  : 42,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                if (recorder.isRecording)
                  StreamBuilder(
                      stream: recorder.onProgress,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const SizedBox();
                        final duration = snapshot.hasData
                            ? snapshot.data!.duration
                            : Duration.zero;
                        String twoDigits(int n) => n.toString().padLeft(2, '0');
                        final twoDigintsMinutes =
                            twoDigits(duration.inMinutes.remainder(60));
                        final twoDigintsSeconds =
                            twoDigits(duration.inSeconds.remainder(60));
                        return Text('$twoDigintsMinutes:$twoDigintsSeconds');
                      }),
                if (recorder.isRecording) const Spacer(),
                Center(
                    child: Icon(
                        recorder.isRecording ? Icons.stop : Icons.mic_none)),
              ])),
        );
      },
    );
  }
}
