import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'chewie_player.dart';

/// A fixed version of Chewie that uses the fixed imports
class CustomChewiePlayer extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool autoPlay;
  final bool looping;
  final bool showControls;
  final bool allowFullScreen;
  final bool allowMuting;
  final bool allowPlaybackSpeedChanging;
  final Widget? placeholder;
  final Duration? startAt;
  final double? aspectRatio;

  const CustomChewiePlayer({
    super.key,
    required this.videoPlayerController,
    this.autoPlay = false,
    this.looping = false,
    this.showControls = true,
    this.allowFullScreen = true,
    this.allowMuting = true,
    this.allowPlaybackSpeedChanging = true,
    this.placeholder,
    this.startAt,
    this.aspectRatio,
  });

  @override
  State<CustomChewiePlayer> createState() => _CustomChewiePlayerState();
}

class _CustomChewiePlayerState extends State<CustomChewiePlayer> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _initializeChewieController();
  }

  void _initializeChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: widget.aspectRatio,
      autoInitialize: true,
      autoPlay: widget.autoPlay,
      looping: widget.looping,
      showControls: widget.showControls,
      allowFullScreen: widget.allowFullScreen,
      allowMuting: widget.allowMuting,
      allowPlaybackSpeedChanging: widget.allowPlaybackSpeedChanging,
      placeholder: widget.placeholder,
      startAt: widget.startAt,
    );
  }

  @override
  void didUpdateWidget(CustomChewiePlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.videoPlayerController != oldWidget.videoPlayerController) {
      _chewieController.dispose();
      _initializeChewieController();
    }
  }

  @override
  void dispose() {
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(controller: _chewieController);
  }
}
