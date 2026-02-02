import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'chewie_player.dart';
import 'cupertino/cupertino_controls.dart';
import 'material/material_controls.dart';
import 'material/material_desktop_controls.dart';

class PlayerWithControls extends StatelessWidget {
  const PlayerWithControls({this.showDesktopControls = false, super.key});

  final bool showDesktopControls;

  @override
  Widget build(BuildContext context) {
    final ChewieController chewieController = context.watch<PlayerNotifier>().chewieController;

    double calculateAspectRatio(BuildContext context) {
      final size = MediaQuery.of(context).size;
      final width = size.width;
      final height = size.height;

      return width > height ? width / height : height / width;
    }

    Widget buildControls(BuildContext context, ChewieController chewieController) {
      if (!chewieController.showControls) {
        return const SizedBox();
      }

      if (Theme.of(context).platform == TargetPlatform.iOS) {
        return CupertinoControls(backgroundColor: Colors.black, iconColor: Colors.white);
      }

      if (showDesktopControls) {
        return MaterialDesktopControls(showPlayButton: chewieController.showControls);
      }

      return MaterialControls(showPlayButton: chewieController.showControls);
    }

    Widget buildPlayerWithControls(BuildContext context, ChewieController chewieController) {
      return Stack(
        children: <Widget>[
          if (chewieController.placeholder != null) chewieController.placeholder!,
          InteractiveViewer(
            panEnabled: chewieController.zoomAndPan,
            boundaryMargin: EdgeInsets.zero,
            minScale: 1.0,
            maxScale: chewieController.maxScale,
            child: Center(
              child: AspectRatio(
                aspectRatio: chewieController.aspectRatio ?? calculateAspectRatio(context),
                child: VideoPlayer(chewieController.videoPlayerController),
              ),
            ),
          ),
          if (chewieController.overlay != null) chewieController.overlay!,
          if (Theme.of(context).platform != TargetPlatform.iOS) buildControls(context, chewieController),
        ],
      );
    }

    return buildPlayerWithControls(context, chewieController);
  }
}
