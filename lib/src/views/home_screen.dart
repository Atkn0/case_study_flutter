import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';
import '../widgets/home/home_body.dart';
import '../widgets/home/home_drawer.dart';
import '../widgets/home/home_app_bar.dart';
import '../widgets/home/home_bottom_nav_bar.dart';

class HomeScreenWidget extends StatefulWidget {
  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color(0xFF1F1D2B),
        appBar: HomeAppBar(
          onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        drawer: const HomeDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: HomeBody(
            searchController: _searchController,
            searchFocusNode: _searchFocusNode,
          ),
        ),
        bottomNavigationBar: HomeBottomNavBar(currentIndex: 0, onTap: (_) {}),
      ),
    );
  }
}
