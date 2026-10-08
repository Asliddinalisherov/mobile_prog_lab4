import 'package:flutter/material.dart';

void main() {
  runApp(const Task10App());
}

/// Task 10: Structural Containers (Card & ExpansionTile)
/// Exercise 10.1: Design an information card containing a header, subtitle, leading Icon, and trailing action button inside a Card.
/// Exercise 10.2: Create an FAQ screen using multiple ExpansionTile widgets that expand/collapse detailed text answers when tapped.
class Task10App extends StatelessWidget {
  const Task10App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task 10: Structural Containers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const StructuralContainersScreen(),
    );
  }
}

class StructuralContainersScreen extends StatefulWidget {
  const StructuralContainersScreen({super.key});

  @override
  State<StructuralContainersScreen> createState() => _StructuralContainersScreenState();
}

class _StructuralContainersScreenState extends State<StructuralContainersScreen> {
  bool _isBookmarked = false;

  final List<Map<String, String>> _faqList = [
    {
      'question': 'What is the difference between StatelessWidget and StatefulWidget?',
      'answer':
          'A StatelessWidget is immutable and cannot change its appearance or state during its lifetime once built.\n\nIn contrast, a StatefulWidget maintains state across build calls and can trigger UI updates whenever setState() is invoked.',
    },
    {
      'question': 'Why should we use ListView.builder instead of standard ListView?',
      'answer':
          'ListView.builder constructs list children on-demand (lazy evaluation) as they scroll into view. This avoids instantiating all children at once, dramatically optimizing memory and rendering performance for long or infinite collections.',
    },
    {
      'question': 'How does the Dismissible widget manage item removal?',
      'answer':
          'Dismissible requires a unique Key for every item. When a user swipes an item away, Flutter triggers the onDismissed callback where the developer must remove the item from the backing data structure to prevent key collision crashes.',
    },
    {
      'question': 'What does BuildContext represent in Flutter?',
      'answer':
          'BuildContext is a handle to the location of a widget within the overall widget tree. It is used to locate inherited widgets, navigate with Navigator, show SnackBars, or query the active Theme.',
    },
    {
      'question': 'What are the main benefits of Card and ExpansionTile?',
      'answer':
          'Cards group related content with visual depth and elevation. ExpansionTiles conserve mobile screen space by allowing users to selectively expand and collapse detailed text on demand.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 10: Card & ExpansionTile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section 1 Header: Exercise 10.1
            Text(
              'Exercise 10.1: Information Card',
              style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 8),

            // Exercise 10.1: Information card containing header, subtitle, leading Icon, and trailing action button inside a Card
            Card(
              elevation: 4,
              shadowColor: theme.colorScheme.shadow.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: theme.colorScheme.outlineVariant.withOpacity(0.5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header row with leading Icon, Header, Subtitle, and Trailing action button
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Leading Icon
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.flutter_dash,
                            color: theme.colorScheme.onPrimaryContainer,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 14),

                        // Header (Title) & Subtitle
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Flutter Mobile Architecture',
                                style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Lab 4: Advanced Material Widgets',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.outline,
                                    ),
                              ),
                            ],
                          ),
                        ),

                        // Trailing Action Button
                        IconButton(
                          icon: Icon(
                            _isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: _isBookmarked
                                ? theme.colorScheme.primary
                                : Colors.grey,
                          ),
                          tooltip: 'Bookmark',
                          onPressed: () {
                            setState(() {
                              _isBookmarked = !_isBookmarked;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  _isBookmarked
                                      ? 'Card saved to bookmarks!'
                                      : 'Card removed from bookmarks.',
                                ),
                                duration: const Duration(seconds: 1),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    const Divider(height: 24),

                    // Additional Card Content
                    Text(
                      'This information card demonstrates elevation, rounded corners, responsive padding, and integrated action controls inside a Material 3 Card widget.',
                      style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
                    ),
                    const SizedBox(height: 14),

                    // Footer action row inside the Card
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Dismissed info card details.'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: const Text('Dismiss'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Opening documentation...'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          icon: const Icon(Icons.open_in_new, size: 16),
                          label: const Text('Explore Docs'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Section 2 Header: Exercise 10.2
            Text(
              'Exercise 10.2: Frequently Asked Questions (FAQ)',
              style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Tap each question below to expand or collapse the detailed answers.',
              style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
            ),
            const SizedBox(height: 12),

            // Exercise 10.2: Multiple ExpansionTile widgets for FAQ
            ...List.generate(_faqList.length, (index) {
              final item = _faqList[index];
              return Card(
                elevation: 1,
                margin: const EdgeInsets.only(bottom: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: theme.colorScheme.outlineVariant.withOpacity(0.4),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ExpansionTile(
                    leading: CircleAvatar(
                      radius: 16,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Text(
                        'Q${index + 1}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    title: Text(
                      item['question']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(height: 1),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            size: 20,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item['answer']!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                    height: 1.4,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
