# Custom Chewie Player

This folder contains a customized version of the Chewie video player that fixes issues with missing imports in the original Chewie package (v1.11.3).

## Issues Fixed

1. Fixed missing `WakelockPlus` import in `chewie_player.dart`
2. Fixed missing `Provider` import in control files:
   - `cupertino_controls.dart`
   - `material_controls.dart`
   - `material_desktop_controls.dart`
3. Fixed missing `Consumer` widget in `player_with_controls.dart`

## How to Use

Instead of using the original Chewie player directly, use our `VideoPlayerWidget` which wraps the custom Chewie implementation:

```dart
// Import the video player widget
import 'package:ustahub/infrastructure/services/video_player/video_player_widget.dart';

// Use it in your widget tree
VideoPlayerWidget(
  videoUrl: 'https://example.com/video.mp4',
  autoPlay: true,
  looping: false,
  showControls: true,
  aspectRatio: 16 / 9,
  placeholder: Center(child: CircularProgressIndicator()),
)
```

## Advanced Usage

If you need more control, you can directly use the `CustomChewiePlayer` class:

```dart
import 'package:ustahub/infrastructure/services/video_player/custom_chewie/custom_chewie_player.dart';
import 'package:video_player/video_player.dart';

// Create a VideoPlayerController
final videoPlayerController = VideoPlayerController.networkUrl(
  Uri.parse('https://example.com/video.mp4'),
);

// Initialize the controller
await videoPlayerController.initialize();

// Use the CustomChewiePlayer
CustomChewiePlayer(
  videoPlayerController: videoPlayerController,
  autoPlay: true,
  looping: false,
  // ...other options
)
```

## Required Dependencies

Make sure these dependencies are in your pubspec.yaml:

```yaml
dependencies:
  video_player: ^2.8.2 # Already in your project
  provider: ^6.0.1 # Already in your project
  wakelock_plus: ^1.1.4 # Added for the fix
  chewie: ^1.11.3 # Added for compatibility
```
