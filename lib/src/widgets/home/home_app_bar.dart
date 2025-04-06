import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenuTap;

  const HomeAppBar({required this.onMenuTap});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: onMenuTap,
      ),
    );
  }
}
