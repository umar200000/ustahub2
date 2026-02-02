import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../chewie_player.dart';

class CupertinoControls extends StatefulWidget {
  const CupertinoControls({required this.backgroundColor, required this.iconColor, super.key});

  final Color backgroundColor;
  final Color iconColor;

  @override
  State<StatefulWidget> createState() {
    return _CupertinoControlsState();
  }
}

class _CupertinoControlsState extends State<CupertinoControls> {
  late PlayerNotifier notifier;

  @override
  void didChangeDependencies() {
    notifier = Provider.of<PlayerNotifier>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ChewieController controller = notifier.chewieController;
    final bool isFinished = controller.videoPlayerController.value.position >= controller.videoPlayerController.value.duration;

    return Container(
      color: widget.backgroundColor.withOpacity(0.4),
      child: Center(
        child: IconButton(
          onPressed: () {
            if (isFinished) {
              controller.seekTo(Duration.zero);
            }
            controller.videoPlayerController.value.isPlaying ? controller.pause() : controller.play();
          },
          icon: Icon(
            controller.videoPlayerController.value.isPlaying ? CupertinoIcons.pause_solid : CupertinoIcons.play_fill,
            color: widget.iconColor,
            size: 32,
          ),
        ),
      ),
    );
  }
}
