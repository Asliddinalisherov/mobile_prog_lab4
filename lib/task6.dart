import 'package:flutter/material.dart';

void main() {
  runApp(const Task6App());
}

/// Task 6: Sliders & Pickers (Slider & showDatePicker)
/// Exercise 6.1: Build a custom volume control screen using a Slider widget that dynamically updates a displayed percentage text.
/// Exercise 6.2: Add a button that opens a native date picker via showDatePicker and displays the formatted date.
class Task6App extends StatelessWidget {
  const Task6App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task 6: Sliders & Pickers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepOrange,
      ),
      home: const SlidersPickersScreen(),
    );
  }
}

class SlidersPickersScreen extends StatefulWidget {
  const SlidersPickersScreen({super.key});

  @override
  State<SlidersPickersScreen> createState() => _SlidersPickersScreenState();
}

class _SlidersPickersScreenState extends State<SlidersPickersScreen> {
  // Exercise 6.1: Volume slider state (0 to 100)
  double _volume = 65.0;

  // Exercise 6.2: Selected date state
  DateTime? _selectedDate;

  // Helper method to format date cleanly
  String _formatDate(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    final day = date.day.toString().padLeft(2, '0');
    final monthName = months[date.month - 1];
    final year = date.year;
    return '$day $monthName $year';
  }

  // Exercise 6.2: Open native date picker
  Future<void> _pickDate() async {
    final DateTime initial = _selectedDate ?? DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2035),
      helpText: 'SELECT APPOINTMENT DATE',
      confirmText: 'CONFIRM',
      cancelText: 'CANCEL',
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Selected Date: ${_formatDate(picked)}'),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  IconData _getVolumeIcon() {
    if (_volume == 0) return Icons.volume_mute;
    if (_volume < 50) return Icons.volume_down;
    return Icons.volume_up;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 6: Sliders & Pickers'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Exercise 6.1: Volume Control using Slider
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(_getVolumeIcon(), color: theme.colorScheme.primary, size: 28),
                        const SizedBox(width: 10),
                        Text(
                          'Volume Control (Exercise 6.1)',
                          style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Level: ${_volume.round()}%',
                            style: theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _volume == 0
                                ? 'Muted'
                                : _volume == 100
                                    ? 'Maximum Volume'
                                    : 'Dynamic Volume Percentage',
                            style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.outline,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.volume_mute, size: 20),
                        Expanded(
                          child: Slider(
                            value: _volume,
                            min: 0.0,
                            max: 100.0,
                            divisions: 100,
                            label: '${_volume.round()}%',
                            onChanged: (double newValue) {
                              setState(() {
                                _volume = newValue;
                              });
                            },
                          ),
                        ),
                        const Icon(Icons.volume_up, size: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Exercise 6.2: Native Date Picker via showDatePicker
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_month, color: theme.colorScheme.primary, size: 28),
                        const SizedBox(width: 10),
                        Text(
                          'Calendar Input (Exercise 6.2)',
                          style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceVariant.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.colorScheme.outlineVariant,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Formatted Date Output:',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _selectedDate != null
                                ? _formatDate(_selectedDate!)
                                : 'No date picked yet. Press the button below.',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _selectedDate != null
                                  ? theme.colorScheme.primary
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_today_outlined),
                      label: Text(
                        _selectedDate == null ? 'Select Date' : 'Change Date',
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
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
