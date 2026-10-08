# Mobile Programming - Laboratory Work 4: Flutter Mobile Widgets

Testing Common Flutter Widgets for Mobile (iOS / Android)  
**Author:** Mukhammadali Khayotov  
**Duration:** 90 Minutes  

---

## 📁 Project Structure

Each task is implemented as a standalone, runnable Flutter application in its own `.dart` file:

| Task File | Objective & Key Widgets | Exercises Implemented |
| :--- | :--- | :--- |
| **`task1.dart`** | **Selection Controls** (`CheckboxListTile` & `SwitchListTile`) | • **1.1:** Settings screen with "Dark Mode" switch & "Agree to Terms" checkbox.<br>• **1.2:** Dynamic enabling/disabling of `ElevatedButton` based on terms agreement. |
| **`task2.dart`** | **Input Fields** (`TextField` & `TextFormField`) | • **2.1:** Login form with password obscure text toggle.<br>• **2.2:** Built-in form validation enforcing `@` symbol in email field. |
| **`task3.dart`** | **Buttons & Action Items** (`FloatingActionButton` & `ElevatedButton`) | • **3.1:** FloatingActionButton in bottom corner that increments counter.<br>• **3.2:** Secondary `OutlinedButton` resetting counter to 0. |
| **`task4.dart`** | **Indicators & Feedback** (`CircularProgressIndicator` & `SnackBar`) | • **4.1:** Centered CircularProgressIndicator for 3 seconds upon button tap.<br>• **4.2:** SnackBar notification with interactive "Undo" action upon completion. |
| **`task5.dart`** | **Dialogs & Modals** (`AlertDialog` & `showModalBottomSheet`) | • **5.1:** Confirmation `AlertDialog` for item deletion with "Cancel" and "Delete".<br>• **5.2:** Bottom action sheet via `showModalBottomSheet` containing share `ListTile` options. |
| **`task6.dart`** | **Sliders & Pickers** (`Slider` & `showDatePicker`) | • **6.1:** Custom volume control with `Slider` dynamically updating percentage text.<br>• **6.2:** Button opening native calendar picker via `showDatePicker` and displaying formatted date. |
| **`task7.dart`** | **Scrollable Collections** (`ListView.builder` & `ListTile`) | • **7.1:** Dynamic list of 20 items using `ListView.builder` with `ListTile`.<br>• **7.2:** Swipe-to-dismiss gesture handling using `Dismissible` with undo capability. |
| **`task8.dart`** | **Grid Displays** (`GridView.count`) | • **8.1:** 2-column image gallery with `crossAxisSpacing` and `mainAxisSpacing`.<br>• **8.2:** `InkWell` wrapper opening interactive full-screen preview. |
| **`task9.dart`** | **Navigation Controls** (`BottomNavigationBar` & `TabBar`) | • **9.1:** 3-tab layout via `BottomNavigationBar` switching views dynamically.<br>• **9.2:** Top tab interface using `TabBar` and `TabBarView` inside an `AppBar`. |
| **`task10.dart`** | **Structural Containers** (`Card` & `ExpansionTile`) | • **10.1:** Information card with header, subtitle, leading Icon, and trailing action button.<br>• **10.2:** FAQ screen with multiple `ExpansionTile` widgets expanding/collapsing answers. |
| **`main.dart`** | **Interactive Lab Dashboard** | Unified launcher allowing you to browse and test all 10 tasks from a single menu. |

---

## 🚀 How to Run

### Run the Interactive Multi-Task Hub:
```bash
flutter run lib/main.dart
```

### Run Any Specific Task Directly:
```bash
flutter run lib/task1.dart
flutter run lib/task2.dart
flutter run lib/task3.dart
flutter run lib/task4.dart
flutter run lib/task5.dart
flutter run lib/task6.dart
flutter run lib/task7.dart
flutter run lib/task8.dart
flutter run lib/task9.dart
flutter run lib/task10.dart
```
*(Files are also present directly in the project root directory).*
