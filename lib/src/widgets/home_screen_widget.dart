import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';
import '../widgets/search_and_filters.dart';
import '../widgets/podcast_card.dart';
import '../widgets/category_selector_row.dart';
import '../models/category.dart';
import '../widgets/now_playing_screen_widget.dart';

class HomeScreenWidget extends StatefulWidget {
  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final homeVM = Provider.of<HomeViewModel>(context, listen: false);
      homeVM.fetchPodcasts();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeVM = Provider.of<HomeViewModel>(context);
    final categories = ["All", "Life", "Comedy", "Tech"];
    final selectedCategory = homeVM.selectedCategory.name;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFF1F1D2B),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1F1D2B),
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Podkes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("You have no notifications")),
                );
              },
            ),
          ],
          leading: Builder(
            builder:
                (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: const Color(0xFF1F1D2B),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Color(0xFF1F1D2B)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: Icon(
                        Icons.podcasts,
                        color: Color(0xFF1A1A2E),
                        size: 40,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Podkes",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Your personalized podcast station.",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.info, color: Colors.white),
                title: const Text(
                  "About Us",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder:
                        (_) => AlertDialog(
                          backgroundColor: const Color(0xFF1F1D2B),
                          title: const Text(
                            "About Us",
                            style: TextStyle(color: Colors.white),
                          ),
                          content: const Text(
                            "Podkes is an app designed to help you explore and listen to your favorite podcasts. "
                            "With a user-friendly interface and a large podcast library, we aim to provide easy access to knowledge and entertainment.",
                            style: TextStyle(color: Colors.white70),
                          ),
                          actions: [
                            TextButton(
                              child: const Text(
                                "Close",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                  );
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              homeVM.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SearchBarWidget(
                        controller: _searchController,
                        focusNode: _searchFocusNode,
                        onChanged: (value) => homeVM.searchPodcasts(value),
                      ),
                      const SizedBox(height: 16),
                      CategorySelectorRow(
                        categories: categories,
                        selectedCategory: selectedCategory,
                        onCategorySelected: (name) {
                          final category = Category(
                            id: name.toLowerCase(),
                            name: name,
                          );
                          homeVM.filterByCategory(category);
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
                                : GridView.builder(
                                  itemCount: homeVM.filteredPodcasts.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 16,
                                        crossAxisSpacing: 16,
                                        childAspectRatio: 0.75,
                                      ),
                                  itemBuilder: (context, index) {
                                    final podcast =
                                        homeVM.filteredPodcasts[index];
                                    final colors = [
                                      Colors.purple,
                                      Colors.blue,
                                      Colors.orange,
                                      Colors.teal,
                                    ];
                                    return PodcastCard(
                                      podcast: podcast,
                                      backgroundColor:
                                          colors[index % colors.length],
                                      onTap: () {
                                        homeVM.selectPodcast(podcast);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (_) => NowPlayingScreenWidget(
                                                  podcastList:
                                                      homeVM.filteredPodcasts,
                                                  initialIndex: index,
                                                ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                      ),
                    ],
                  ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          onTap: (_) {},
          backgroundColor: const Color(0xFF1A1A2E),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          selectedLabelStyle: const TextStyle(fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_music),
              label: "Library",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
