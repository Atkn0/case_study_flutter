import 'package:flutter/material.dart';
import '../models/podcast.dart';
import '../models/category.dart';

class HomeViewModel extends ChangeNotifier {
  List<Podcast> podcasts = [];
  List<Podcast> filteredPodcasts = [];
  Category selectedCategory = Category(id: 'all', name: 'All');
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchPodcasts() async {}
  void filterByCategory(Category category) {}
  void searchPodcasts(String query) {}
  void selectPodcast(Podcast podcast) {}
}
