import 'package:flutter/material.dart';
import 'task1.dart';
import 'task2.dart';
import 'task3.dart';
import 'task4.dart';
import 'task5.dart';
import 'task6.dart';
import 'task7.dart';
import 'task8.dart';
import 'task9.dart';
import 'task10.dart';

void main() {
  runApp(const Lab4LauncherApp());
}

/// Launcher App for Mobile Programming Lab 4
class Lab4LauncherApp extends StatelessWidget {
  const Lab4LauncherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4: Flutter Mobile Widgets',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const LabLauncherDashboard(),
    );
  }
}

class LabTaskInfo {
  final String title;
  final String subtitle;
  final String fileName;
  final IconData icon;
  final Color color;
  final Widget destination;

  const LabTaskInfo({
    required this.title,
    required this.subtitle,
    required this.fileName,
    required this.icon,
    required this.color,
    required this.destination,
  });
}

class LabLauncherDashboard extends StatelessWidget {
  const LabLauncherDashboard({super.key});

  static final List<LabTaskInfo> tasks = [
    const LabTaskInfo(
      title: 'Task 1: Selection Controls',
      subtitle: 'SwitchListTile (Dark Mode) & CheckboxListTile (Terms)',
      fileName: 'task1.dart',
      icon: Icons.toggle_on,
      color: Colors.indigo,
      destination: Task1App(),
    ),
    const LabTaskInfo(
      title: 'Task 2: Input Fields & Validation',
      subtitle: 'TextFormField login form, obscure toggle, @ check',
      fileName: 'task2.dart',
      icon: Icons.input,
      color: Colors.teal,
      destination: Task2App(),
    ),
    const LabTaskInfo(
      title: 'Task 3: Buttons & Action Items',
      subtitle: 'FloatingActionButton counter & OutlinedButton reset',
      fileName: 'task3.dart',
      icon: Icons.smart_button,
      color: Colors.deepPurple,
      destination: Task3App(),
    ),
    const LabTaskInfo(
      title: 'Task 4: Indicators & Feedback',
      subtitle: '3-second CircularProgressIndicator & SnackBar with Undo',
      fileName: 'task4.dart',
      icon: Icons.timelapse,
      color: Colors.amber,
      destination: Task4App(),
    ),
    const LabTaskInfo(
      title: 'Task 5: Dialogs & Modals',
      subtitle: 'AlertDialog (Delete confirmation) & showModalBottomSheet',
      fileName: 'task5.dart',
      icon: Icons.call_to_action,
      color: Colors.blueGrey,
      destination: Task5App(),
    ),
    const LabTaskInfo(
      title: 'Task 6: Sliders & Pickers',
      subtitle: 'Volume Slider & native showDatePicker calendar',
      fileName: 'task6.dart',
      icon: Icons.tune,
      color: Colors.deepOrange,
      destination: Task6App(),
    ),
    const LabTaskInfo(
      title: 'Task 7: Scrollable Collections',
      subtitle: 'ListView.builder (20 items) & Dismissible swipe-to-delete',
      fileName: 'task7.dart',
      icon: Icons.format_list_bulleted,
      color: Colors.green,
      destination: Task7App(),
    ),
    const LabTaskInfo(
      title: 'Task 8: Grid Displays',
      subtitle: '2-column GridView.count gallery with full-screen preview',
      fileName: 'task8.dart',
      icon: Icons.grid_view,
      color: Colors.cyan,
      destination: Task8App(),
    ),
    const LabTaskInfo(
      title: 'Task 9: Navigation Controls',
      subtitle: '3-tab BottomNavigationBar & AppBar top TabBar/TabBarView',
      fileName: 'task9.dart',
      icon: Icons.navigation,
      color: Colors.indigoAccent,
      destination: Task9App(),
    ),
    const LabTaskInfo(
      title: 'Task 10: Structural Containers',
      subtitle: 'Information Card with action button & FAQ ExpansionTiles',
      fileName: 'task10.dart',
      icon: Icons.dashboard_customize,
      color: Colors.blue,
      destination: Task10App(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 4: Flutter Mobile Widgets'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primaryContainer,
                    theme.colorScheme.secondaryContainer,
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Laboratory Work 4: Mobile Programming',
                    style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Testing Common Flutter Widgets for Mobile (iOS / Android)',
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap any module below to launch its interactive implementation.',
                    style: TextStyle(fontSize: 12, color: theme.colorScheme.outline),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final task = tasks[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 6.0,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: task.color.withOpacity(0.15),
                        child: Icon(task.icon, color: task.color),
                      ),
                      title: Text(
                        task.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 2),
                          Text(task.subtitle),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              task.fileName,
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: Colors.blueGrey.shade800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => task.destination,
                          ),
                        );
                      },
                    ),
                  );
                },
                childCount: tasks.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
