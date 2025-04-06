import 'package:flutter/material.dart';
import '../../models/podcast.dart';
import '../podcast_card.dart';

class PodcastGrid extends StatelessWidget {
  final List<Podcast> podcasts;
  final Function(int) onTap;

  const PodcastGrid({required this.podcasts, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = [Colors.purple, Colors.blue, Colors.orange, Colors.teal];

    return GridView.builder(
      itemCount: podcasts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final podcast = podcasts[index];
        return PodcastCard(
          podcast: podcast,
          backgroundColor: colors[index % colors.length],
          onTap: () => onTap(index),
        );
      },
    );
  }
}
