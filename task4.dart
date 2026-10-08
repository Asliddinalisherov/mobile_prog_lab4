import 'package:flutter/material.dart';

void main() {
  runApp(const Task4App());
}

/// Task 4: Indicators & Feedback (CircularProgressIndicator & SnackBar)
/// Exercise 4.1: Implement a button that shows a centered CircularProgressIndicator for 3 seconds when tapped.
/// Exercise 4.2: Display a SnackBar notification at the bottom of the screen with an "Undo" action upon completion.
class Task4App extends StatelessWidget {
  const Task4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task 4: Indicators & Feedback',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.amber,
      ),
      home: const FeedbackScreen(),
    );
  }
}

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  // Exercise 4.1 loading state
  bool _isLoading = false;
  String _statusText = 'Ready to begin task';

  Future<void> _startAsyncOperation() async {
    // 1. Start loading
    setState(() {
      _isLoading = true;
      _statusText = 'Performing 3-second asynchronous operation...';
    });

    // 2. Wait for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // 3. Complete loading
    setState(() {
      _isLoading = false;
      _statusText = 'Task finished successfully!';
    });

    // Exercise 4.2: Display SnackBar with "Undo" action
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.greenAccent),
            SizedBox(width: 8),
            Text('Operation completed successfully!'),
          ],
        ),
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.amberAccent,
          onPressed: () {
            setState(() {
              _statusText = 'Action was undone by the user.';
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Operation reversed (Undo).'),
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 4: Feedback & Indicators'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 36.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Exercise 4.1: Centered CircularProgressIndicator when loading
                      if (_isLoading) ...[
                        const SizedBox(
                          width: 56,
                          height: 56,
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Processing Operation...',
                          style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Simulating network request for 3 seconds',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ] else ...[
                        Icon(
                          Icons.sync,
                          size: 64,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Status: $_statusText',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tap below to run the 3-second simulation and trigger the SnackBar.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.outline,
                              ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Trigger button
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _startAsyncOperation,
                icon: const Icon(Icons.play_arrow),
                label: Text(
                  _isLoading ? 'Processing...' : 'Run Async Task (3 sec)',
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 16,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
