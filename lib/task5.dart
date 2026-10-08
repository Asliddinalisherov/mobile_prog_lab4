import 'package:flutter/material.dart';

void main() {
  runApp(const Task5App());
}

/// Task 5: Dialogs & Modals (AlertDialog & showModalBottomSheet)
/// Exercise 5.1: Implement an AlertDialog asking confirmation to delete an item with "Cancel" and "Delete" actions.
/// Exercise 5.2: Create a bottom action sheet using showModalBottomSheet containing share options (ListTile items).
class Task5App extends StatelessWidget {
  const Task5App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task 5: Dialogs & Modals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blueGrey,
      ),
      home: const ModalsScreen(),
    );
  }
}

class ModalsScreen extends StatefulWidget {
  const ModalsScreen({super.key});

  @override
  State<ModalsScreen> createState() => _ModalsScreenState();
}

class _ModalsScreenState extends State<ModalsScreen> {
  // Mock list of items for deletion demonstration
  final List<String> _items = [
    'Document_Project_Report.pdf',
    'Flutter_Lab4_Source_Code.zip',
    'Mobile_Programming_Syllabus.docx',
  ];

  // Exercise 5.1: AlertDialog for confirmation to delete an item
  Future<void> _showDeleteConfirmationDialog(int index) async {
    final String itemToDelete = _items[index];

    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.delete_outline,
            color: Colors.red,
            size: 40,
          ),
          title: const Text('Confirm Deletion'),
          content: Text(
            'Are you sure you want to delete "$itemToDelete"?\nThis action cannot be undone.',
          ),
          actions: <Widget>[
            // "Cancel" action
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            // "Delete" action
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed == true && mounted) {
      setState(() {
        _items.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Deleted "$itemToDelete"'),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // Exercise 5.2: Bottom action sheet using showModalBottomSheet
  void _showShareBottomSheet(String itemName) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Text(
                    'Share "$itemName"',
                    style: Theme.of(sheetContext).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const Divider(),
                // Share options implemented as ListTile items (Exercise 5.2)
                ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.link),
                  ),
                  title: const Text('Copy Link'),
                  subtitle: const Text('Copy direct link to clipboard'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showFeedback('Link copied to clipboard');
                  },
                ),
                ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.email_outlined),
                  ),
                  title: const Text('Share via Email'),
                  subtitle: const Text('Send file as an email attachment'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showFeedback('Opened email client');
                  },
                ),
                ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.chat_bubble_outline),
                  ),
                  title: const Text('Send Message'),
                  subtitle: const Text('Share with contacts on Telegram / WhatsApp'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showFeedback('Opened messaging');
                  },
                ),
                ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.qr_code),
                  ),
                  title: const Text('Generate QR Code'),
                  subtitle: const Text('Scan to download on mobile device'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showFeedback('QR Code generated');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFeedback(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 5: Dialogs & Modals'),
        centerTitle: true,
      ),
      body: _items.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.folder_open, size: 64, color: Colors.grey),
                  const SizedBox(height: 12),
                  const Text('All items have been deleted!'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _items.addAll([
                          'Document_Project_Report.pdf',
                          'Flutter_Lab4_Source_Code.zip',
                          'Mobile_Programming_Syllabus.docx',
                        ]);
                      });
                    },
                    child: const Text('Reset Items List'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.insert_drive_file),
                    ),
                    title: Text(
                      item,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: const Text('Tap actions below or right'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Exercise 5.2: Share action triggering showModalBottomSheet
                        IconButton(
                          icon: const Icon(Icons.share, color: Colors.blueAccent),
                          tooltip: 'Share item (Modal Bottom Sheet)',
                          onPressed: () => _showShareBottomSheet(item),
                        ),
                        // Exercise 5.1: Delete action triggering AlertDialog
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          tooltip: 'Delete item (Alert Dialog)',
                          onPressed: () => _showDeleteConfirmationDialog(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
