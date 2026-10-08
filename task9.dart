import 'package:flutter/material.dart';

void main() {
  runApp(const Task9App());
}

/// Task 9: Navigation Controls (BottomNavigationBar & TabBar)
/// Exercise 9.1: Construct a 3-tab layout using BottomNavigationBar that switches displayed views dynamically.
/// Exercise 9.2: Implement a top tab interface using TabBar and TabBarView inside an AppBar.
class Task9App extends StatelessWidget {
  const Task9App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task 9: Navigation Controls',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const NavigationMasterScreen(),
    );
  }
}

class NavigationMasterScreen extends StatefulWidget {
  const NavigationMasterScreen({super.key});

  @override
  State<NavigationMasterScreen> createState() => _NavigationMasterScreenState();
}

class _NavigationMasterScreenState extends State<NavigationMasterScreen> {
  // Exercise 9.1: State for BottomNavigationBar
  int _currentBottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    // 3 Dynamic views switched by BottomNavigationBar
    final List<Widget> pages = [
      // View 1: Showcases Exercise 9.2 (Top TabBar and TabBarView inside AppBar)
      const TopTabBarDemoView(),
      // View 2: Explore view
      const ExploreView(),
      // View 3: Profile view
      const ProfileView(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentBottomNavIndex,
        children: pages,
      ),
      // Exercise 9.1: 3-tab layout using BottomNavigationBar
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentBottomNavIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentBottomNavIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.tab_outlined),
            selectedIcon: Icon(Icons.tab),
            label: 'Top Tabs (Ex 9.2)',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

/// Exercise 9.2: Top tab interface using TabBar and TabBarView inside an AppBar
class TopTabBarDemoView extends StatelessWidget {
  const TopTabBarDemoView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // 3 top tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Top TabBar & TabBarView'),
          centerTitle: true,
          // Exercise 9.2: TabBar placed in the bottom of AppBar
          bottom: const TabBar(
            indicatorWeight: 3,
            tabs: [
              Tab(
                icon: Icon(Icons.local_fire_department),
                text: 'Trending',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Popular',
              ),
              Tab(
                icon: Icon(Icons.new_releases),
                text: 'Recent',
              ),
            ],
          ),
        ),
        // Exercise 9.2: TabBarView matching the TabBar items
        body: TabBarView(
          children: [
            _buildTabContent(
              context,
              title: 'Trending Articles & News',
              icon: Icons.local_fire_department,
              color: Colors.orange,
              description:
                  'Demonstrating Exercise 9.2: TabBar inside AppBar driving TabBarView smoothly.',
            ),
            _buildTabContent(
              context,
              title: 'Most Popular Content',
              icon: Icons.star,
              color: Colors.amber,
              description:
                  'Swipe left or right or tap the tabs above to switch views effortlessly.',
            ),
            _buildTabContent(
              context,
              title: 'Recently Added Modules',
              icon: Icons.new_releases,
              color: Colors.purple,
              description:
                  'Each tab is hosted inside a dedicated page in TabBarView.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required String description,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: color.withOpacity(0.15),
                  child: Icon(icon, size: 40, color: color),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Second screen of BottomNavigationBar (Exercise 9.1)
class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore View'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.explore, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 8),
                      const Text(
                        'BottomNavigationBar Screen 2',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'This view is displayed dynamically when the second tab in the BottomNavigationBar is selected (Exercise 9.1).',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(
            5,
            (index) => ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text('Explore Topic #${index + 1}'),
              subtitle: const Text('Content loaded inside BottomNav tab 2'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}

/// Third screen of BottomNavigationBar (Exercise 9.1)
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 60),
              ),
              const SizedBox(height: 16),
              const Text(
                'Student Developer',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'student@university.edu',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'BottomNavigationBar Tab 3: Switches displayed views dynamically as required by Exercise 9.1.',
                    textAlign: TextAlign.center,
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
