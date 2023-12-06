import 'package:audioplayers/audioplayers.dart';

class PlayKeyAudio {
  static final player = AudioPlayer();
  playAudio() async {
    await player.play(AssetSource("audio/countdown_tick.mp3"));
  }
}