import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';
import '../providers/basic_provider.dart';
import '../widgets/search_and_filters.dart';
import '../widgets/podcast_card.dart';
import '../widgets/category_selector_row.dart';
import '../models/category.dart';

class HomeScreenWidget extends StatefulWidget {
  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final homeVM = Provider.of<HomeViewModel>(context, listen: false);
      homeVM.fetchPodcasts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final basicProvider = Provider.of<BasicProvider>(context);
    final homeVM = Provider.of<HomeViewModel>(context);
    final categories = ["All", "Life", "Comedy", "Tech"];
    final selectedCategory = homeVM.selectedCategory.name;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
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
        child: ListView(
          children: const [
            DrawerHeader(
              child: Text("Menu"),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(leading: Icon(Icons.info), title: Text("About")),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            homeVM.isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchBarWidget(
                      controller: _searchController,
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
                              ? Center(
                                child: Text(
                                  'No podcasts found.',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              )
                              : GridView.builder(
                                itemCount: homeVM.filteredPodcasts.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
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
                                    onTap: () => homeVM.selectPodcast(podcast),
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
        onTap: (index) {
          // Sayfa değişimi burada yönetilir
        },
        backgroundColor: const Color(0xFF1A1A2E),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        selectedLabelStyle: TextStyle(fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: "Library",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
