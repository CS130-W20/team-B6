import 'package:rxdart/rxdart.dart';

enum PlaybackState { pause, play }


class NewsStoryActions {

  final storyNotification = BehaviorSubject<PlaybackState>();

  void pause() {
    storyNotification.add(PlaybackState.pause);
  }

  void play() {
    storyNotification.add(PlaybackState.play);
  }

  /// closing the notification stream.
  void dispose() {
    storyNotification.close();
  }
}
