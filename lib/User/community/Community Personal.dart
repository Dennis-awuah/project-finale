import 'package:flutter/material.dart';
import 'package:police_app/Screens/AlertsScreen.dart';
import 'package:police_app/Screens/NotificationsScreen.dart';
import 'package:police_app/Screens/menu_screen.dart';
import 'package:police_app/User/community/Community%20screen%20.dart';

class CommunityDashboard extends StatefulWidget {
  @override
  _CommunityDashboardState createState() => _CommunityDashboardState();
}

class _CommunityDashboardState extends State<CommunityDashboard> {
  int _selectedIndex = 0; // Currently selected index for the bottom nav bar
  PageController _pageController = PageController(); // Controller for PageView

  // List of different screens for navigation
  final List<Widget> _screens = [
    CommunityScreen(), // Main Community screen (your current one)
    AlertsScreen(), // Replace with actual screen
    NotificationsScreen(), // Replace with actual screen
    MenuScreen(), // Replace with actual screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index
    });
    _pageController.jumpToPage(index); // Navigate to the selected page
  }

  void _logout() {
    // Implement your logout functionality here
    print("User logged out");
    // You can add a navigation to the login screen here after logging out.
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Community Dashboard',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        actions: [
          ElevatedButton(
            onPressed: _logout,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow, // Logout button color
            ),
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins', // Add Poppins font
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background_image-removebg.png'), // Replace with your image path
                fit: BoxFit.cover, // Make sure the image covers the entire screen
              ),
            ),
          ),
          // Faded Overlay
          Container(
            color: const Color.fromARGB(255, 243, 242, 242).withOpacity(0.5), // Adjust opacity for the fade effect
          ),
          // Foreground content (PageView and screens)
          PageView(
            controller: _pageController, // Controller for page view
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index; // Update index when page changes
              });
            },
            children: _screens, // List of screens
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
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
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Poppins', // Add Poppins font to selected label
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Poppins', // Add Poppins font to unselected label
        ),
      ),
    );
  }
}
