import 'package:flutter/material.dart';

void main() {
  runApp(const Task1App());
}

/// Task 1: Selection Controls (Checkbox & Switch)
/// Exercise 1.1: Settings screen with SwitchListTile ("Dark Mode") and CheckboxListTile ("Agree to Terms").
/// Exercise 1.2: Toggling "Agree to Terms" enables/disables an ElevatedButton below it.
class Task1App extends StatefulWidget {
  const Task1App({super.key});

  @override
  State<Task1App> createState() => _Task1AppState();
}

class _Task1AppState extends State<Task1App> {
  // Theme state for Exercise 1.1
  bool _isDarkMode = false;

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task 1: Selection Controls',
      debugShowCheckedModeBanner: false,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: SettingsScreen(
        isDarkMode: _isDarkMode,
        onThemeChanged: _toggleTheme,
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Checkbox state for Exercise 1.1 and 1.2
  bool _agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 1: Settings Screen'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Preferences & Agreements',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Exercise 1.1 & Exercise 1.2 Implementation',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                    ),
                    const Divider(height: 24),

                    // Exercise 1.1: SwitchListTile for "Dark Mode"
                    SwitchListTile(
                      title: const Text(
                        'Dark Mode',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        widget.isDarkMode
                            ? 'Dark theme is currently active'
                            : 'Light theme is currently active',
                      ),
                      secondary: Icon(
                        widget.isDarkMode
                            ? Icons.dark_mode
                            : Icons.light_mode,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      value: widget.isDarkMode,
                      onChanged: (bool value) {
                        widget.onThemeChanged(value);
                      },
                    ),

                    const Divider(height: 16),

                    // Exercise 1.1: CheckboxListTile for "Agree to Terms"
                    CheckboxListTile(
                      title: const Text(
                        'Agree to Terms',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text(
                        'I accept the terms and conditions and privacy policy',
                      ),
                      secondary: Icon(
                        Icons.verified_user_outlined,
                        color: _agreedToTerms
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outline,
                      ),
                      value: _agreedToTerms,
                      onChanged: (bool? value) {
                        setState(() {
                          _agreedToTerms = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Exercise 1.2: ElevatedButton enabled/disabled based on "Agree to Terms"
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _agreedToTerms
                              ? Icons.check_circle_outline
                              : Icons.info_outline,
                          color: _agreedToTerms ? Colors.green : Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _agreedToTerms
                                ? 'Terms accepted: Button enabled'
                                : 'Accept terms above to enable the submit button',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      // Exercise 1.2: null disables button, non-null callback enables it
                      onPressed: _agreedToTerms
                          ? () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Success! Terms agreed and form submitted.',
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          : null,
                      icon: const Icon(Icons.arrow_forward),
                      label: Text(
                        _agreedToTerms ? 'Continue to Next Step' : 'Disabled (Accept Terms)',
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
