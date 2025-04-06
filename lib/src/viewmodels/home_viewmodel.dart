import 'package:flutter/material.dart';
import '../models/podcast.dart';
import '../models/category.dart';

class HomeViewModel extends ChangeNotifier {
  List<Podcast> podcasts = [];
  List<Podcast> filteredPodcasts = [];
  Category selectedCategory = Category(id: 'all', name: 'All');
  bool isLoading = false;
  String? errorMessage;

  final List<Podcast> _dummyData = [
    Podcast(
      id: '1',
      title: 'Mindset Matters',
      author: 'John Doe',
      coverImageUrl: 'assets/images/podcast_image.png',
      category: 'Life',
    ),
    Podcast(
      id: '2',
      title: 'Tech Trends 2024',
      author: 'Jane Smith',
      coverImageUrl: 'assets/images/podcast_image_2.png',
      category: 'Tech',
    ),
    Podcast(
      id: '3',
      title: 'Laugh Factory',
      author: 'Comedian X',
      coverImageUrl: 'assets/images/podcast_image_3.png',
      category: 'Comedy',
    ),
    Podcast(
      id: '4',
      title: 'Life Hacks',
      author: 'LifeGuru',
      coverImageUrl: 'assets/images/podcast_image_4.png',
      category: 'Life',
    ),
    Podcast(
      id: '5',
      title: 'Tech Talks',
      author: 'InnovatorX',
      coverImageUrl: 'assets/images/podcast_image.png',
      category: 'Tech',
    ),
    Podcast(
      id: '6',
      title: 'Comedy Hour',
      author: 'FunnyGuy',
      coverImageUrl: 'assets/images/podcast_image.png',
      category: 'Comedy',
    ),
    Podcast(
      id: '7',
      title: 'Mindful Living',
      author: 'ZenMaster',
      coverImageUrl: 'assets/images/podcast_image.png',
      category: 'Life',
    ),
    Podcast(
      id: '8',
      title: 'CodeCast',
      author: 'DevTalks',
      coverImageUrl: 'assets/images/podcast_image.png',
      category: 'Tech',
    ),
  ];

  Future<void> fetchPodcasts() async {
    isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      podcasts = _dummyData;
      filteredPodcasts = List.from(podcasts);
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Failed to load podcasts.';
    }

    isLoading = false;
    notifyListeners();
  }

  void filterByCategory(Category category) {
    selectedCategory = category;
    if (category.name == "All") {
      filteredPodcasts = List.from(podcasts);
    } else {
      filteredPodcasts =
          podcasts.where((p) => p.category == category.name).toList();
    }
    notifyListeners();
  }

  void searchPodcasts(String query) {
    final listToSearch =
        selectedCategory.name == "All"
            ? podcasts
            : podcasts
                .where((p) => p.category == selectedCategory.name)
                .toList();

    filteredPodcasts =
        listToSearch
            .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
            .toList();

    notifyListeners();
  }

  void selectPodcast(Podcast podcast) {}
}
