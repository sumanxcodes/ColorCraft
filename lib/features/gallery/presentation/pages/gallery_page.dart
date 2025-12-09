import 'package:flutter/material.dart';
import '../widgets/theme_input_sidebar.dart';
import '../widgets/gallery_grid.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          ThemeInputSidebar(),
          Expanded(child: GalleryGrid()),
        ],
      ),
    );
  }
}
