import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'player_with_controls.dart';

typedef ChewieRoutePageBuilder =
    Widget Function(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      _ChewieControllerProvider controllerProvider,
    );

/// A Video Player with Material and Cupertino skins.
///
/// `video_player` is pretty low level. Chewie wraps it in a friendly skin to
/// make it easy to use!
class Chewie extends StatefulWidget {
  const Chewie({super.key, required this.controller});

  /// The [ChewieController]
  final ChewieController controller;

  @override
  ChewieState createState() {
    return ChewieState();
  }
}

class ChewieState extends State<Chewie> {
  bool _isFullScreen = false;

  bool get isControllerFullScreen => widget.controller.isFullScreen;
  late PlayerNotifier notifier;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listener);
    notifier = PlayerNotifier.init();
  }

  @override
  void dispose() {
    widget.controller.removeListener(listener);
    super.dispose();
  }

  @override
  void didUpdateWidget(Chewie oldWidget) {
    if (oldWidget.controller != widget.controller) {
      widget.controller.addListener(listener);
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> listener() async {
    if (isControllerFullScreen != _isFullScreen) {
      _isFullScreen = isControllerFullScreen;
      if (isControllerFullScreen) {
        await _pushFullScreenWidget(context);
      } else {
        Navigator.of(context, rootNavigator: widget.controller.useRootNavigator).pop();
        if (widget.controller.wasInFullScreen) {
          widget.controller.wasInFullScreen = false;
          widget.controller.exitFullScreen();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _ChewieControllerProvider(
      controller: widget.controller,
      child: ChangeNotifierProvider<PlayerNotifier>.value(value: notifier, builder: (context, w) => const PlayerWithControls()),
    );
  }

  Widget _buildFullScreenVideo(BuildContext context, Animation<double> animation, _ChewieControllerProvider controllerProvider) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(alignment: Alignment.center, color: Colors.black, child: controllerProvider),
    );
  }

  AnimatedWidget _defaultRoutePageBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    _ChewieControllerProvider controllerProvider,
  ) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return _buildFullScreenVideo(context, animation, controllerProvider);
      },
    );
  }

  Widget _fullScreenRoutePageBuilder(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    final controllerProvider = _ChewieControllerProvider(
      controller: widget.controller,
      child: ChangeNotifierProvider<PlayerNotifier>.value(value: notifier, builder: (context, w) => const PlayerWithControls()),
    );

    if (widget.controller.routePageBuilder == null) {
      return _defaultRoutePageBuilder(context, animation, secondaryAnimation, controllerProvider);
    }
    return widget.controller.routePageBuilder!(context, animation, secondaryAnimation, controllerProvider);
  }

  Future<dynamic> _pushFullScreenWidget(BuildContext context) async {
    final TransitionRoute<void> route = PageRouteBuilder<void>(pageBuilder: _fullScreenRoutePageBuilder, opaque: false);

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    if (widget.controller.enableFullScreen) {
      await WakelockPlus.enable();
    }

    if (!widget.controller.allowedScreenSleep) {
      await WakelockPlus.enable();
    }

    widget.controller.wasInFullScreen = true;
    await Navigator.of(context, rootNavigator: widget.controller.useRootNavigator).push(route);
    _isFullScreen = false;
    widget.controller.exitFullScreen();

    // The wakelock plugins checks whether it needs to perform an action internally,
    // so we don't need to check whether it's already disabled.
    await WakelockPlus.disable();

    await SystemChrome.setEnabledSystemUIMode(widget.controller.systemOverlaysAfterFullScreen);
    await SystemChrome.setPreferredOrientations(widget.controller.deviceOrientationsAfterFullScreen);
  }
}

/// The ChewieController is used to configure and drive the Chewie Player
/// Widgets. It provides methods to control playback, such as [pause] and
/// [play], as well as methods that control the visual appearance of the player,
/// such as [enterFullScreen] or [exitFullScreen].
///
/// In addition, you can listen to the ChewieController for presentational
/// changes, such as entering and exiting full screen mode. To listen for
/// changes to the playback, such as a change to the seek position of the
/// player, please use the standard information provided by the
/// `VideoPlayerController`.
class ChewieController extends ChangeNotifier {
  ChewieController({
    required this.videoPlayerController,
    this.optionsTranslation,
    this.aspectRatio,
    this.autoInitialize = false,
    this.autoPlay = false,
    this.startAt,
    this.looping = false,
    this.fullScreenByDefault = false,
    this.cupertinoProgressColors,
    this.materialProgressColors,
    this.placeholder,
    this.overlay,
    this.showControlsOnInitialize = true,
    this.showOptions = true,
    this.optionsBuilder,
    this.additionalOptions,
    this.showControls = true,
    this.transformationController,
    this.maxScale = 1.0,
    this.subtitle,
    this.subtitleBuilder,
    this.customControls,
    this.errorBuilder,
    this.allowedScreenSleep = true,
    this.isLive = false,
    this.allowFullScreen = true,
    this.allowMuting = true,
    this.allowPlaybackSpeedChanging = true,
    this.useRootNavigator = true,
    this.playbackSpeeds = const [0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2],
    this.systemOverlaysOnEnterFullScreen,
    this.deviceOrientationsOnEnterFullScreen,
    this.systemOverlaysAfterFullScreen = SystemUiMode.edgeToEdge,
    this.deviceOrientationsAfterFullScreen = DeviceOrientation.values,
    this.routePageBuilder,
    this.progressIndicatorDelay,
    this.hideControlsTimer = defaultHideControlsTimer,
    this.enableFullScreen = true,
    this.zoomAndPan = false,
  }) : assert(playbackSpeeds.every((speed) => speed > 0), 'The playbackSpeeds values must all be greater than 0') {
    _initialize();
  }

  ChewieController copyWith({
    VideoPlayerController? videoPlayerController,
    OptionsTranslation? optionsTranslation,
    double? aspectRatio,
    bool? autoInitialize,
    bool? autoPlay,
    Duration? startAt,
    bool? looping,
    bool? fullScreenByDefault,
    ChewieProgressColors? cupertinoProgressColors,
    ChewieProgressColors? materialProgressColors,
    Widget? placeholder,
    Widget? overlay,
    bool? showControlsOnInitialize,
    bool? showOptions,
    Future<void> Function(BuildContext)? optionsBuilder,
    List<OptionItem>? additionalOptions,
    bool? showControls,
    TransformationController? transformationController,
    double? maxScale,
    Subtitles? subtitle,
    Widget Function(BuildContext, dynamic)? subtitleBuilder,
    Widget? customControls,
    Widget Function(BuildContext, String)? errorBuilder,
    bool? allowedScreenSleep,
    bool? isLive,
    bool? allowFullScreen,
    bool? allowMuting,
    bool? allowPlaybackSpeedChanging,
    bool? useRootNavigator,
    List<double>? playbackSpeeds,
    SystemUiMode? systemOverlaysOnEnterFullScreen,
    List<DeviceOrientation>? deviceOrientationsOnEnterFullScreen,
    SystemUiMode? systemOverlaysAfterFullScreen,
    List<DeviceOrientation>? deviceOrientationsAfterFullScreen,
    ChewieRoutePageBuilder? routePageBuilder,
    Duration? progressIndicatorDelay,
    Duration? hideControlsTimer,
    bool? enableFullScreen,
    bool? zoomAndPan,
  }) {
    return ChewieController(
      videoPlayerController: videoPlayerController ?? this.videoPlayerController,
      optionsTranslation: optionsTranslation ?? this.optionsTranslation,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      autoInitialize: autoInitialize ?? this.autoInitialize,
      autoPlay: autoPlay ?? this.autoPlay,
      startAt: startAt ?? this.startAt,
      looping: looping ?? this.looping,
      fullScreenByDefault: fullScreenByDefault ?? this.fullScreenByDefault,
      cupertinoProgressColors: cupertinoProgressColors ?? this.cupertinoProgressColors,
      materialProgressColors: materialProgressColors ?? this.materialProgressColors,
      placeholder: placeholder ?? this.placeholder,
      overlay: overlay ?? this.overlay,
      showControlsOnInitialize: showControlsOnInitialize ?? this.showControlsOnInitialize,
      showOptions: showOptions ?? this.showOptions,
      optionsBuilder: optionsBuilder ?? this.optionsBuilder,
      additionalOptions: additionalOptions ?? this.additionalOptions,
      showControls: showControls ?? this.showControls,
      subtitle: subtitle ?? this.subtitle,
      subtitleBuilder: subtitleBuilder ?? this.subtitleBuilder,
      customControls: customControls ?? this.customControls,
      errorBuilder: errorBuilder ?? this.errorBuilder,
      allowedScreenSleep: allowedScreenSleep ?? this.allowedScreenSleep,
      isLive: isLive ?? this.isLive,
      allowFullScreen: allowFullScreen ?? this.allowFullScreen,
      allowMuting: allowMuting ?? this.allowMuting,
      allowPlaybackSpeedChanging: allowPlaybackSpeedChanging ?? this.allowPlaybackSpeedChanging,
      useRootNavigator: useRootNavigator ?? this.useRootNavigator,
      playbackSpeeds: playbackSpeeds ?? this.playbackSpeeds,
      systemOverlaysOnEnterFullScreen: systemOverlaysOnEnterFullScreen ?? this.systemOverlaysOnEnterFullScreen,
      deviceOrientationsOnEnterFullScreen: deviceOrientationsOnEnterFullScreen ?? this.deviceOrientationsOnEnterFullScreen,
      systemOverlaysAfterFullScreen: systemOverlaysAfterFullScreen ?? this.systemOverlaysAfterFullScreen,
      deviceOrientationsAfterFullScreen: deviceOrientationsAfterFullScreen ?? this.deviceOrientationsAfterFullScreen,
      routePageBuilder: routePageBuilder ?? this.routePageBuilder,
      hideControlsTimer: hideControlsTimer ?? this.hideControlsTimer,
      progressIndicatorDelay: progressIndicatorDelay ?? this.progressIndicatorDelay,
      enableFullScreen: enableFullScreen ?? this.enableFullScreen,
      zoomAndPan: zoomAndPan ?? this.zoomAndPan,
      transformationController: transformationController ?? this.transformationController,
      maxScale: maxScale ?? this.maxScale,
    );
  }

  static const defaultHideControlsTimer = Duration(seconds: 3);

  /// If false, the options button in MaterialUI and MaterialDesktopUI
  /// won't be shown.
  final bool showOptions;

  /// Pass your translations for the options like:
  /// - PlaybackSpeed
  /// - Subtitles
  /// - Cancel
  ///
  /// Don't use if you won't show the options
  ///
  final OptionsTranslation? optionsTranslation;

  /// Build your own options with default chewieOptions comming from
  /// OptionItem getOptionsItems()
  ///
  /// Don't use if you won't show the options
  ///
  final Future<void> Function(BuildContext context)? optionsBuilder;

  /// Add your own additional options on top of the default options
  ///
  /// Don't use if you won't show the options
  ///
  final List<OptionItem>? additionalOptions;

  /// Define here your own Widget on how your controls should look like
  final Widget? customControls;

  /// The controller for the video you want to play
  final VideoPlayerController videoPlayerController;

  /// Initialize the Video on Startup. This will prep the video for playback.
  final bool autoInitialize;

  /// Play the video as soon as it's displayed
  final bool autoPlay;

  /// Start video at a certain position
  final Duration? startAt;

  /// Whether or not the video should loop
  final bool looping;

  /// Weather or not to show the controls when initializing the widget.
  final bool showControlsOnInitialize;

  /// Whether or not to show the controls at all
  final bool showControls;

  /// Controller to manipulate the zoom and pan of the video
  final TransformationController? transformationController;

  /// Max scale when zooming
  final double maxScale;

  /// Defines customised controls. Check [MaterialControls] or
  /// [CupertinoControls] for reference.
  Widget? get controls => customControls;

  /// Defines if the player will start in fullscreen when play is pressed
  final bool fullScreenByDefault;

  /// Defines if the player will sleep in fullscreen or not
  final bool allowedScreenSleep;

  /// Defines if the controls should be for live stream video
  final bool isLive;

  /// Defines if the fullscreen control should be shown
  final bool allowFullScreen;

  /// Defines if the mute control should be shown
  final bool allowMuting;

  /// Defines if the playback speed control should be shown
  final bool allowPlaybackSpeedChanging;

  /// Defines if push/pop navigations use the rootNavigator
  final bool useRootNavigator;

  /// Defines if the video should zoomable and pannable
  final bool zoomAndPan;

  /// Defines if the fullscreen mode should be enabled
  final bool enableFullScreen;

  /// Defines the set of allowed playback speeds user can change
  final List<double> playbackSpeeds;

  /// Defines the system overlays visible on entering fullscreen
  final SystemUiMode? systemOverlaysOnEnterFullScreen;

  /// Defines the set of allowed device orientations on entering fullscreen
  final List<DeviceOrientation>? deviceOrientationsOnEnterFullScreen;

  /// Defines the system overlays visible after exiting fullscreen
  final SystemUiMode systemOverlaysAfterFullScreen;

  /// Defines the set of allowed device orientations after exiting fullscreen
  final List<DeviceOrientation> deviceOrientationsAfterFullScreen;

  /// Defines a custom RoutePageBuilder for the fullscreen
  final ChewieRoutePageBuilder? routePageBuilder;

  /// Defines a delay for the hide controls option.
  /// This delay is used when the show controls options is false
  /// The controls will be shown for this delay and then hidden.
  final Duration? progressIndicatorDelay;

  /// Defines a timer for hide controls.
  final Duration hideControlsTimer;

  /// Subtitle configuration
  final Subtitles? subtitle;

  /// A widget which is placed between the video and the controls
  final Widget? overlay;

  /// A widget which is placed on top of the video and below the controls
  final Widget? placeholder;

  /// Defines if the player is in fullscreen
  bool _isFullScreen = false;

  bool get isFullScreen => _isFullScreen;

  bool wasInFullScreen = false;

  /// Defines the aspect ratio
  final double? aspectRatio;

  /// Defines the color of the video progress indicator for Material
  final ChewieProgressColors? materialProgressColors;

  /// Defines the color of the video progress indicator for Cupertino
  final ChewieProgressColors? cupertinoProgressColors;

  /// Defines the builder for the subtitle
  final Widget Function(BuildContext context, dynamic subtitle)? subtitleBuilder;

  /// Defines the builder for the error widget
  final Widget Function(BuildContext context, String errorMessage)? errorBuilder;

  /// Defines the controller needs to be disposed
  bool _needsDispose = false;

  /// Defines the controller for picture-in-picture mode
  bool _isInPipMode = false;

  bool get isInPipMode => _isInPipMode;

  set isInPipMode(bool value) {
    _isInPipMode = value;
    notifyListeners();
  }

  bool get hasError => videoPlayerController.value.hasError;

  String get errorDescription => videoPlayerController.value.errorDescription!;

  /// Defines whether the backing video should be muted
  bool get isMuted => videoPlayerController.value.volume == 0;

  /// Enter/exit picture-in-picture mode
  Future<void> setPictureInPictureMode(bool isInPipMode) async {
    throw UnsupportedError("The Wakelock plugin doesn't have web support at the moment");
  }

  Future<void> _initialize() async {
    await videoPlayerController.setLooping(looping);

    if ((autoInitialize || autoPlay) && !videoPlayerController.value.isInitialized) {
      await videoPlayerController.initialize();
    }

    if (autoPlay) {
      if (fullScreenByDefault) {
        enterFullScreen();
      }

      await videoPlayerController.play();
    }

    if (startAt != null) {
      await videoPlayerController.seekTo(startAt!);
    }

    if (fullScreenByDefault) {
      videoPlayerController.addListener(_fullScreenListener);
    }
  }

  Future<void> _fullScreenListener() async {
    if (videoPlayerController.value.isPlaying && !_isFullScreen) {
      enterFullScreen();
      videoPlayerController.removeListener(_fullScreenListener);
    }
  }

  void enterFullScreen() {
    _isFullScreen = true;
    notifyListeners();
  }

  void exitFullScreen() {
    _isFullScreen = false;
    notifyListeners();
  }

  void toggleFullScreen() {
    _isFullScreen = !_isFullScreen;
    notifyListeners();
  }

  void togglePictureInPicture() {
    isInPipMode = !isInPipMode;
  }

  Future<void> play() async {
    await videoPlayerController.play();
  }

  Future<void> setLooping(bool looping) async {
    await videoPlayerController.setLooping(looping);
  }

  Future<void> pause() async {
    await videoPlayerController.pause();
  }

  Future<void> seekTo(Duration moment) async {
    await videoPlayerController.seekTo(moment);
  }

  Future<void> setVolume(double volume) async {
    await videoPlayerController.setVolume(volume);
  }

  void setSubtitle(List<Subtitle> newSubtitle) {
    subtitle?.value = newSubtitle;
  }

  Future<void> setPlaybackSpeed(double speed) async {
    await videoPlayerController.setPlaybackSpeed(speed);
  }

  @override
  void dispose() {
    if (_needsDispose) {
      videoPlayerController.dispose();
    }
    super.dispose();
  }
}

class _ChewieControllerProvider extends InheritedWidget {
  const _ChewieControllerProvider({required this.controller, required super.child});

  final ChewieController controller;

  @override
  bool updateShouldNotify(_ChewieControllerProvider oldWidget) => controller != oldWidget.controller;
}

/// A widget to show the playback speed dialog
class PlaybackSpeedDialog extends StatelessWidget {
  /// Initialize the [PlaybackSpeedDialog] widget
  const PlaybackSpeedDialog({super.key, required this.speeds, required this.selected});

  /// The speeds used
  final List<double> speeds;

  /// The current selected speed
  final double selected;

  @override
  Widget build(BuildContext context) {
    final Color selectedColor = Theme.of(context).primaryColor;

    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        final double speed = speeds[index];
        return ListTile(
          dense: true,
          title: Row(
            children: [
              if (speed == selected) Icon(Icons.check, size: 20.0, color: selectedColor) else Container(width: 20.0),
              const SizedBox(width: 16.0),
              Text(speed.toString()),
            ],
          ),
          selected: speed == selected,
          onTap: () {
            Navigator.of(context).pop(speed);
          },
        );
      },
      itemCount: speeds.length,
    );
  }
}

class PlayerNotifier extends ChangeNotifier {
  PlayerNotifier._(this._chewieController);

  final ChewieController _chewieController;

  factory PlayerNotifier.init() {
    return PlayerNotifier._(
      ChewieController(
        videoPlayerController: VideoPlayerController.network(''),
        aspectRatio: 16 / 9,
        autoPlay: true,
        looping: true,
      ),
    );
  }

  factory PlayerNotifier.create(ChewieController chewieController) {
    return PlayerNotifier._(chewieController);
  }

  ChewieController get chewieController => _chewieController;
}

/// Option class used in [optionsBuilder] as return value and
/// used in [additionalOptions].
class OptionItem {
  /// Creates an [OptionItem].
  const OptionItem({required this.onTap, required this.iconData, required this.title, this.subtitle});

  /// onTap callback
  final void Function() onTap;

  /// Optional subtitle
  final String? subtitle;

  /// Option title (e.g. Playback speed)
  final String title;

  /// Icon to display
  final IconData iconData;
}

/// Translations for options like: [PlaybackSpeed] & [Subtitles]
class OptionsTranslation {
  /// Creates an [OptionsTranslation].
  const OptionsTranslation({
    required this.playbackSpeedButtonText,
    required this.subtitlesButtonText,
    required this.cancelButtonText,
  });

  /// Title for playback speed button
  final String playbackSpeedButtonText;

  /// Title for subtitles button
  final String subtitlesButtonText;

  /// Title for cancel button
  final String cancelButtonText;
}

/// Define the colors of the Material progress bar.
class ChewieProgressColors {
  /// Defines the colors of the Material progress bar.
  ChewieProgressColors({
    this.playedColor = const Color.fromRGBO(255, 0, 0, 0.7),
    this.handleColor = const Color.fromRGBO(255, 0, 0, 0.9),
    this.bufferedColor = const Color.fromRGBO(30, 30, 200, 0.4),
    this.backgroundColor = const Color.fromRGBO(200, 200, 200, 0.5),
  });

  /// The color of the progress bar portion that corresponds
  /// to the progress of the video that has been watched.
  final Color playedColor;

  /// The color of the progress bar portion that represents
  /// the videos that have been buffered but not watched.
  final Color bufferedColor;

  /// The color of the progress bar's background.
  final Color backgroundColor;

  /// The color of the progress bar's handle.
  final Color handleColor;
}

class Subtitles {
  Subtitles(List<Subtitle> subtitles) : _values = subtitles;

  final List<Subtitle> _values;
  List<Subtitle> get value => _values;

  set value(List<Subtitle> newSubtitles) {
    if (_values == newSubtitles) return;
    _values.clear();
    _values.addAll(newSubtitles);
  }

  void clear() {
    _values.clear();
  }
}

class Subtitle {
  Subtitle(this.index, this.start, this.end, this.text);

  final int index;
  final Duration start;
  final Duration end;
  final String text;

  @override
  String toString() => '[$index] $start --> $end: $text';
}
