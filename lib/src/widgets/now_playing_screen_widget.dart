import 'package:flutter/material.dart';
import '../models/podcast.dart';

class NowPlayingScreenWidget extends StatelessWidget {
  final Podcast podcast;

  const NowPlayingScreenWidget({required this.podcast});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        leading: BackButton(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Now Playing',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: Text(podcast.title, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
