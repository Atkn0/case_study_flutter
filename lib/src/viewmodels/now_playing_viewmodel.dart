import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../models/podcast.dart';

class NowPlayingViewModel extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late final StreamSubscription<PlayerState> _playerStateSub;
  late final StreamSubscription<Duration> _positionSub;
  late final StreamSubscription<Duration?> _durationSub;

  List<Podcast> _playlist = [];
  int _currentIndex = 0;
  bool _isPlaying = false;
  String? _errorMessage;

  Podcast? get currentPodcast =>
      _playlist.isNotEmpty ? _playlist[_currentIndex] : null;
  bool get isPlaying => _isPlaying;
  String? get errorMessage => _errorMessage;
  Duration get currentPosition => _audioPlayer.position;
  Duration get audioDuration => _audioPlayer.duration ?? Duration.zero;

  NowPlayingViewModel(List<Podcast> playlist, int initialIndex) {
    _playlist = playlist;
    _currentIndex = initialIndex;
    _initialize();
  }

  Future<void> _initialize() async {
    _playerStateSub = _audioPlayer.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      notifyListeners();
    });

    _positionSub = _audioPlayer.positionStream.listen((_) {
      notifyListeners();
    });

    _durationSub = _audioPlayer.durationStream.listen((_) {
      notifyListeners();
    });

    await loadPodcast(_playlist[_currentIndex]);
  }

  Future<void> loadPodcast(Podcast podcast) async {
    try {
      await _audioPlayer.setAsset("assets/audio/sample.mp3");
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Podcast yüklenirken hata oluştu.';
      notifyListeners();
    }
  }

  Future<void> play() async {
    if (_audioPlayer.processingState == ProcessingState.ready) {
      await _audioPlayer.play();
    }
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  Future<void> seekTo(Duration position) async {
    await _audioPlayer.seek(position);
  }

  Future<void> skipToNext() async {
    if (_currentIndex < _playlist.length - 1) {
      _currentIndex++;
      await loadPodcast(_playlist[_currentIndex]);
      await play();
    }
  }

  Future<void> skipToPrevious() async {
    if (_currentIndex > 0) {
      _currentIndex--;
      await loadPodcast(_playlist[_currentIndex]);
      await play();
    }
  }

  @override
  void dispose() {
    _playerStateSub.cancel();
    _positionSub.cancel();
    _durationSub.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }
}
