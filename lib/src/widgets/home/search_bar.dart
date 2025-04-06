import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function(String) onChanged;

  const SearchBarWidget({
    required this.controller,
    this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3D),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autofocus: false,
              focusNode: focusNode,
              controller: controller,
              onChanged: onChanged,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                hintText: 'Search podcasts',
                hintStyle: TextStyle(color: Colors.white60),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Icon(Icons.search, color: Colors.white.withOpacity(0.6), size: 30),
        ],
      ),
    );
  }
}
