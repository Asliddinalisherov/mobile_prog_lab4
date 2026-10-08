import 'package:flutter/material.dart';

void main() {
  runApp(const Task3App());
}

/// Task 3: Buttons & Action Items (FloatingActionButton & ElevatedButton)
/// Exercise 3.1: Create a counter screen featuring a FloatingActionButton in the bottom corner that increments a counter.
/// Exercise 3.2: Add a secondary OutlinedButton that resets the counter value back to 0.
class Task3App extends StatelessWidget {
  const Task3App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task 3: Buttons & Action Items',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  // Counter state
  int _counter = 0;

  // Exercise 3.1: Increment action
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Decrement action using ElevatedButton
  void _decrementCounter() {
    setState(() {
      if (_counter > 0) _counter--;
    });
  }

  // Exercise 3.2: Reset action
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Counter has been reset to 0.'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 3: Counter Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48.0,
                    vertical: 36.0,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Current Count',
                        style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.outline,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 12),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: Text(
                          '$_counter',
                          key: ValueKey<int>(_counter),
                          style: theme.textTheme.displayLarge?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _counter == 0
                            ? 'Tap + button to begin counting'
                            : '$_counter tap${_counter == 1 ? '' : 's'} recorded',
                        style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.outline,
                            ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // ElevatedButton for decrement / primary actions
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _counter > 0 ? _decrementCounter : null,
                    icon: const Icon(Icons.remove),
                    label: const Text('Decrement'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),

                  // Exercise 3.2: Secondary OutlinedButton that resets counter to 0
                  OutlinedButton.icon(
                    onPressed: _counter != 0 ? _resetCounter : null,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset Counter'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      foregroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // Exercise 3.1: FloatingActionButton in bottom corner that increments counter
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment Counter (Exercise 3.1)',
        child: const Icon(Icons.add),
      ),
    );
  }
}
