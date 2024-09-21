import 'package:flutter/material.dart';
import 'package:syllout_v3/screens/home_screen.dart';
import 'package:syllout_v3/screens/creator_screen.dart';
import 'package:syllout_v3/screens/profile_screen.dart';
import 'package:syllout_v3/screens/vertical_video_screen.dart'; // Import Vertical Video Screen
import 'package:syllout_v3/screens/explore_screen.dart'; // Import Explore Screen
import 'package:syllout_v3/theme.dart';

void main() {
  runApp(SylloutApp());
}

class SylloutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'syllout_v3',
      theme: sylloutTheme, // Apply your custom theme here
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    CreatorScreen(),
    CareerMentorScreen(), // Add Vertical Vi// Add Explore Screen to the list
    ProfileScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology),
            label: 'Ai Mentor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
