import 'package:flutter/material.dart';

void main() {
  runApp(const Task7App());
}

/// Task 7: Scrollable Collections (ListView.builder & ListTile)
/// Exercise 7.1: Generate a dynamic list of 20 items using ListView.builder where each entry is rendered as a ListTile.
/// Exercise 7.2: Implement swipe-to-dismiss functionality for list items using the Dismissible widget wrapper.
class Task7App extends StatelessWidget {
  const Task7App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task 7: Scrollable Collections',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: const ScrollableListScreen(),
    );
  }
}

class ScrollableListScreen extends StatefulWidget {
  const ScrollableListScreen({super.key});

  @override
  State<ScrollableListScreen> createState() => _ScrollableListScreenState();
}

class _ScrollableListScreenState extends State<ScrollableListScreen> {
  // Exercise 7.1: Dynamic list of 20 items
  late List<String> _items;

  @override
  void initState() {
    super.initState();
    _resetList();
  }

  void _resetList() {
    setState(() {
      _items = List.generate(
        20,
        (index) => 'Flutter UI Component #${index + 1}',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 7: Dynamic List & Dismissible'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset 20 Items',
            onPressed: () {
              _resetList();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Reset list back to 20 items.'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: _items.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.checklist, size: 72, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'All items have been dismissed!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _resetList,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reload 20 Items'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
                  child: Row(
                    children: [
                      const Icon(Icons.swipe, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Showing ${_items.length} items. Swipe any item left or right to dismiss.',
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  // Exercise 7.1: ListView.builder dynamic generation of 20 items
                  child: ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      final item = _items[index];

                      // Exercise 7.2: Swipe-to-dismiss functionality via Dismissible wrapper
                      return Dismissible(
                        key: Key(item),
                        direction: DismissDirection.horizontal,
                        // Background when swiping from left to right
                        background: Container(
                          color: Colors.red.shade600,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: const Row(
                            children: [
                              Icon(Icons.delete, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Secondary background when swiping from right to left
                        secondaryBackground: Container(
                          color: Colors.red.shade600,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Dismiss',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.delete_sweep, color: Colors.white),
                            ],
                          ),
                        ),
                        onDismissed: (direction) {
                          final removedItem = _items[index];
                          setState(() {
                            _items.removeAt(index);
                          });

                          // Feedback with Undo option
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Dismissed "$removedItem"'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  setState(() {
                                    _items.insert(index, removedItem);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                        // Exercise 7.1: Entry rendered as a ListTile
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              foregroundColor: Colors.white,
                              child: Text('${index + 1}'),
                            ),
                            title: Text(
                              item,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text('Index: $index | Lazy-loaded item'),
                            trailing: const Icon(Icons.drag_indicator, color: Colors.grey),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
