import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/home_viewmodel.dart';
import 'category_selector.dart';
import '../../views/now_playing_screen.dart';
import 'search_bar.dart';
import '../../models/category.dart';
import 'podcast_grid.dart';

class HomeBody extends StatelessWidget {
  final TextEditingController searchController;
  const HomeBody({required this.searchController});

  @override
  Widget build(BuildContext context) {
    final homeVM = Provider.of<HomeViewModel>(context);
    final categories = ["All", "Life", "Comedy", "Tech"];
    final selectedCategory = homeVM.selectedCategory.name;

    if (homeVM.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchBarWidget(
          controller: searchController,
          onChanged: (value) => homeVM.searchPodcasts(value),
        ),
        const SizedBox(height: 16),
        CategorySelectorRow(
          categories: categories,
          selectedCategory: selectedCategory,
          onCategorySelected: (name) {
            homeVM.filterByCategory(
              Category(id: name.toLowerCase(), name: name),
            );
          },
        ),
        const SizedBox(height: 24),
        const Text(
          "Trending",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child:
              homeVM.filteredPodcasts.isEmpty
                  ? const Center(
                    child: Text(
                      'No podcasts found.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  )
                  : PodcastGrid(
                    podcasts: homeVM.filteredPodcasts,
                    onTap: (index) {
                      final podcast = homeVM.filteredPodcasts[index];
                      homeVM.selectPodcast(podcast);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => NowPlayingScreenWidget(
                                playlist: homeVM.filteredPodcasts,
                                initialIndex: index,
                              ),
                        ),
                      );
                    },
                  ),
        ),
      ],
    );
  }
}
