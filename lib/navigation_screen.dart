import 'package:flutter/material.dart';
import 'package:translation_test/home_screen.dart';
import 'package:translation_test/map_screen.dart';
import 'package:translation_test/utilities/assets_list.dart';
import 'package:translation_test/utilities/pre_cache.dart';
import 'package:translation_test/widgets/custom_bottom_nav_bar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  //asset optimization

  Future<void> precacheAllAssets(BuildContext context) async {
    // Precache regular images

    for (final image in imageAssets) {
      await precacheImage(AssetImage(image), context);
    }

    // Precache SVGs

    for (final svg in svgAssets) {
      await precacheSvg(assetPath: svg);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheAllAssets(context);
  }

  int _selectedIndex = 2;

  // Animation controller for the sliding effect
  late AnimationController _mapScreenController;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  // Pages for BottomNavigationBar
  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _mapScreenController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pages = [
      MapScreen(
        controller: _mapScreenController,
      ),
      const SearchPage(),
      HomeScreen(
        controller: _controller,
      ),
      const FavouritesPage(),
      const ProfilePage(),
    ];
    // Initialize the animation controller

    // Create the sliding animation for the BottomNavigationBar
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start from below the screen
      end: const Offset(0, 0), // End at the normal position (bottom of screen)
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.9, 1, curve: Curves.easeInOut),
      ),
    );

    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _mapScreenController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      _mapScreenController.reset();
      Future.delayed(const Duration(milliseconds: 300), () {
        _mapScreenController.forward(from: 0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Page content
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 700),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: KeyedSubtree(
              // Important: Give each page a UniqueKey to trigger animation
              key: ValueKey<int>(_selectedIndex),
              child: _pages[_selectedIndex],
            ),
          ),

          // Animated Bottom Navigation Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: _slideAnimation,
              child: CustomBottomNav(
                onItemTapped: _onItemTapped,
                selectedIndex: _selectedIndex,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Example pages for the BottomNavigationBar
class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Favourites Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Message Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Profile Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
