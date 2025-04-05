import 'package:flutter/material.dart';
import '../models/podcast.dart';

class LibraryViewModel extends ChangeNotifier {
  List<Podcast> favoritedPodcasts = [];

  void loadFavoritedPodcasts(List<Podcast> allPodcasts) {}
}
