import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
    );
  }
}
