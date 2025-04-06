import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../models/podcast.dart';

class NowPlayingScreenWidget extends StatefulWidget {
  final List<Podcast> podcastList;
  final int initialIndex;

  const NowPlayingScreenWidget({
    Key? key,
    required this.podcastList,
    required this.initialIndex,
  }) : super(key: key);

  @override
  State<NowPlayingScreenWidget> createState() => _NowPlayingScreenWidgetState();
}

class _NowPlayingScreenWidgetState extends State<NowPlayingScreenWidget> {
  late final AudioPlayer _audioPlayer;
  late int currentIndex;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool isPlaying = false;

  Podcast get currentPodcast => widget.podcastList[currentIndex];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    currentIndex = widget.initialIndex;
    _loadAndPlay(currentIndex);

    _audioPlayer.playerStateStream.listen((state) {
      final playing = state.playing;
      final processing = state.processingState;
      final isActuallyPlaying =
          playing && processing != ProcessingState.completed;

      if (mounted) {
        setState(() {
          isPlaying = isActuallyPlaying;
        });
      }
    });

    _audioPlayer.positionStream.listen((p) {
      if (mounted) {
        setState(() => _position = p);
      }
    });

    _audioPlayer.durationStream.listen((d) {
      if (d != null && mounted) {
        setState(() => _duration = d);
      }
    });
  }

  Future<void> _loadAndPlay(int index) async {
    await _audioPlayer.setAsset('assets/audio/sample.mp3');
    await _audioPlayer.seek(Duration.zero);
    await _audioPlayer.play();
  }

  void _togglePlayPause() {
    if (_audioPlayer.playing) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }

  void _playPrevious() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        _position = Duration.zero;
        _duration = Duration.zero;
      });
      _loadAndPlay(currentIndex);
    } else {
      _audioPlayer.seek(Duration.zero);
    }
  }

  void _playNext() {
    if (currentIndex < widget.podcastList.length - 1) {
      setState(() {
        currentIndex++;
        _position = Duration.zero;
        _duration = Duration.zero;
      });
      _loadAndPlay(currentIndex);
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1D2B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1D2B),
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Now Playing',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                currentPodcast.coverImageUrl,
                height: 300,
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              currentPodcast.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              currentPodcast.author,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 32),
            Slider(
              activeColor: Colors.white,
              inactiveColor: Colors.white24,
              min: 0,
              max: _duration.inSeconds.toDouble(),
              value:
                  _position.inSeconds.clamp(0, _duration.inSeconds).toDouble(),
              onChanged: (value) {
                _audioPlayer.seek(Duration(seconds: value.toInt()));
              },
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDuration(_position),
                  style: const TextStyle(color: Colors.white60, fontSize: 12),
                ),
                Text(
                  _formatDuration(_duration),
                  style: const TextStyle(color: Colors.white60, fontSize: 12),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 32,
                  icon: const Icon(Icons.skip_previous, color: Colors.white),
                  onPressed: _playPrevious,
                ),
                const SizedBox(width: 24),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: IconButton(
                    iconSize: 36,
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Color(0xFF121212),
                    ),
                    onPressed: _togglePlayPause,
                  ),
                ),
                const SizedBox(width: 24),
                IconButton(
                  iconSize: 32,
                  icon: const Icon(Icons.skip_next, color: Colors.white),
                  onPressed: _playNext,
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
