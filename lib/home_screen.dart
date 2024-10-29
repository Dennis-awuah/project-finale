import 'package:flutter/material.dart';
import 'package:police_app/Screens/AlertsScreen.dart';
import 'package:police_app/Screens/NotificationsScreen.dart';
import 'package:police_app/Screens/ReportIncidentScreen.dart';
import 'package:police_app/Screens/menu_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of the different screens corresponding to the navigation items
  final List<Widget> _screens = [
    ReportIncidentScreen(),
    AlertsScreen(),
    NotificationsScreen(),
    MenuScreen(),
  ];

  // Method to handle navigation item taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle()), // Dynamic title based on screen
        backgroundColor: Colors.blueAccent,
      ),
      body: _screens[_selectedIndex], // Displays the selected screen
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Keeps all items visible
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
        currentIndex: _selectedIndex, // Highlights the selected item
        onTap: _onItemTapped, // Calls function on tap
        selectedItemColor: Colors.blueAccent, // Active icon color
        unselectedItemColor: Colors.grey, // Inactive icon color
      ),
    );
  }

  // Method to dynamically set the AppBar title based on the selected screen
  String _getAppBarTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Report Incident';
      case 1:
        return 'Alerts';
      case 2:
        return 'Notifications';
      case 3:
        return 'Menu';
      default:
        return 'Home';
    }
  }
}
