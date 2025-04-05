import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../models/podcast.dart';

class NowPlayingViewModel extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Podcast? currentPodcast;
  Duration currentPosition = Duration.zero;
  bool isPlaying = false;
  String? errorMessage;

  Future<void> loadPodcast(Podcast podcast) async {}
  Future<void> play() async {}
  Future<void> pause() async {}
  Future<void> skipNext() async {}
  Future<void> skipPrevious() async {}
  Future<void> updatePosition(Duration position) async {}
}
