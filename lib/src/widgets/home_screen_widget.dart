import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';
import '../providers/basic_provider.dart';

class HomeScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final basicProvider = Provider.of<BasicProvider>(context);
    final homeVM = Provider.of<HomeViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Bildiriminiz yoktur")));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text("Menu"),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About"),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter: ${basicProvider.counter}'),
            ElevatedButton(
              onPressed: () => basicProvider.increment(),
              child: Text('Increment'),
            ),
            Text('Total Podcasts: ${homeVM.podcasts.length}'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {},
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: "Library",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_filled),
            label: "Now Playing",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
