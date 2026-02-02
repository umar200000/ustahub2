import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ustahub/infrastructure/services/video_player/custom_chewie/chewie_player.dart';

class MaterialControls extends StatefulWidget {
  const MaterialControls({required this.showPlayButton, super.key});

  final bool showPlayButton;

  @override
  State<StatefulWidget> createState() {
    return _MaterialControlsState();
  }
}

class _MaterialControlsState extends State<MaterialControls> {
  late PlayerNotifier notifier;

  @override
  void didChangeDependencies() {
    notifier = Provider.of<PlayerNotifier>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ChewieController controller = notifier.chewieController;
    final bool isFinished =
        controller.videoPlayerController.value.position >=
        controller.videoPlayerController.value.duration;

    if (!widget.showPlayButton) {
      return const SizedBox();
    }

    return Container(
      color: Colors.black.withOpacity(0.4),
      child: Center(
        child: IconButton(
          onPressed: () {
            if (isFinished) {
              controller.seekTo(Duration.zero);
            }
            controller.videoPlayerController.value.isPlaying
                ? controller.pause()
                : controller.play();
          },
          icon: Icon(
            controller.videoPlayerController.value.isPlaying
                ? Icons.pause
                : Icons.play_arrow,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }
}
