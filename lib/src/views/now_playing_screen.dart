import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/podcast.dart';
import '../viewmodels/now_playing_viewmodel.dart';

class NowPlayingScreenWidget extends StatelessWidget {
  final List<Podcast> playlist;
  final int initialIndex;

  const NowPlayingScreenWidget({
    Key? key,
    required this.playlist,
    required this.initialIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NowPlayingViewModel(playlist, initialIndex),
      child: Scaffold(
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
        body: Consumer<NowPlayingViewModel>(
          builder: (context, viewModel, child) {
            final podcast = viewModel.currentPodcast;
            if (podcast == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.errorMessage != null) {
              return Center(
                child: Text(
                  viewModel.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      podcast.coverImageUrl,
                      height: 300,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    podcast.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    podcast.author,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 32),
                  Slider(
                    activeColor: Colors.white,
                    inactiveColor: Colors.white24,
                    min: 0,
                    max: viewModel.audioDuration.inSeconds.toDouble(),
                    value:
                        viewModel.currentPosition.inSeconds
                            .clamp(0, viewModel.audioDuration.inSeconds)
                            .toDouble(),
                    onChanged: (value) {
                      viewModel.seekTo(Duration(seconds: value.toInt()));
                    },
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(viewModel.currentPosition),
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        _formatDuration(viewModel.audioDuration),
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 32,
                        icon: const Icon(
                          Icons.skip_previous,
                          color: Colors.white,
                        ),
                        onPressed: viewModel.skipToPrevious,
                      ),
                      const SizedBox(width: 24),
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF2F3142),
                        ),
                        child: IconButton(
                          iconSize: 36,
                          icon: Icon(
                            viewModel.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            viewModel.isPlaying
                                ? viewModel.pause()
                                : viewModel.play();
                          },
                        ),
                      ),
                      const SizedBox(width: 24),
                      IconButton(
                        iconSize: 32,
                        icon: const Icon(Icons.skip_next, color: Colors.white),
                        onPressed: viewModel.skipToNext,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
