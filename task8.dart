import 'package:flutter/material.dart';

void main() {
  runApp(const Task8App());
}

/// Task 8: Grid Displays (GridView.count)
/// Exercise 8.1: Create a 2-column image gallery using GridView.count with cross-axis spacing.
/// Exercise 8.2: Wrap each grid item in an InkWell or GestureDetector to show a full-screen preview when tapped.
class Task8App extends StatelessWidget {
  const Task8App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task 8: Grid Displays',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.cyan,
      ),
      home: const ImageGalleryScreen(),
    );
  }
}

class GalleryItem {
  final String title;
  final String imageUrl;
  final String description;
  final IconData fallbackIcon;

  const GalleryItem({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.fallbackIcon,
  });
}

class ImageGalleryScreen extends StatelessWidget {
  const ImageGalleryScreen({super.key});

  static const List<GalleryItem> galleryItems = [
    GalleryItem(
      title: 'Mountain Sunrise',
      imageUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=600&auto=format&fit=crop',
      description: 'A breathtaking sunrise over the misty alpine mountains.',
      fallbackIcon: Icons.landscape,
    ),
    GalleryItem(
      title: 'Ocean Waves',
      imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=600&auto=format&fit=crop',
      description: 'Crystal turquoise waves rolling across pristine white sand.',
      fallbackIcon: Icons.water,
    ),
    GalleryItem(
      title: 'Forest Mist',
      imageUrl: 'https://images.unsplash.com/photo-1448375240586-882707db888b?w=600&auto=format&fit=crop',
      description: 'Sunlight filtering through towering pine trees in the morning mist.',
      fallbackIcon: Icons.park,
    ),
    GalleryItem(
      title: 'Night Sky Aurora',
      imageUrl: 'https://images.unsplash.com/photo-1531366936337-7c912a4589a7?w=600&auto=format&fit=crop',
      description: 'Vibrant aurora borealis dancing across the arctic night sky.',
      fallbackIcon: Icons.nights_stay,
    ),
    GalleryItem(
      title: 'Desert Dunes',
      imageUrl: 'https://images.unsplash.com/photo-1509316975850-ff9c5deb0cd9?w=600&auto=format&fit=crop',
      description: 'Golden ripples of endless desert sand dunes under the setting sun.',
      fallbackIcon: Icons.wb_sunny,
    ),
    GalleryItem(
      title: 'City Architecture',
      imageUrl: 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=600&auto=format&fit=crop',
      description: 'Modern glass skyscrapers reaching into the clear blue sky.',
      fallbackIcon: Icons.location_city,
    ),
  ];

  void _openFullScreenPreview(BuildContext context, GalleryItem item, int index) {
    // Exercise 8.2: Show full-screen preview when tapped
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenPreviewPage(
          item: item,
          heroTag: 'gallery_img_$index',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 8: 2-Column Gallery'),
        centerTitle: true,
      ),
      // Exercise 8.1: 2-column image gallery using GridView.count with cross-axis spacing
      body: GridView.count(
        crossAxisCount: 2, // 2 columns
        crossAxisSpacing: 12.0, // Cross-axis spacing
        mainAxisSpacing: 12.0, // Main-axis spacing
        childAspectRatio: 0.85,
        padding: const EdgeInsets.all(12.0),
        children: List.generate(galleryItems.length, (index) {
          final item = galleryItems[index];

          // Exercise 8.2: Wrapped in InkWell for interactive full-screen preview
          return Card(
            elevation: 3,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              onTap: () => _openFullScreenPreview(context, item, index),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Hero(
                      tag: 'gallery_img_$index',
                      child: Image.network(
                        item.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey.shade200,
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2.5),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade300,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(item.fallbackIcon, size: 40, color: Colors.blueGrey),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Image Preview',
                                    style: TextStyle(fontSize: 11, color: Colors.blueGrey),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(Icons.fullscreen, size: 18, color: Colors.grey),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// Full-screen preview viewer for Exercise 8.2
class FullScreenPreviewPage extends StatelessWidget {
  final GalleryItem item;
  final String heroTag;

  const FullScreenPreviewPage({
    super.key,
    required this.item,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.7),
        foregroundColor: Colors.white,
        title: Text(item.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(item.description),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: InteractiveViewer(
                  panEnabled: true,
                  minScale: 0.8,
                  maxScale: 4.0,
                  child: Hero(
                    tag: heroTag,
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(item.fallbackIcon, size: 80, color: Colors.white70),
                              const SizedBox(height: 16),
                              Text(
                                item.title,
                                style: const TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.black87,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Pinch to zoom / Double tap to inspect (Full-screen preview)',
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
