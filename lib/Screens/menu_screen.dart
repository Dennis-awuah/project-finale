import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[50]!, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildMenuItem(
              context,
              Icons.person,
              'View Your Profile',
              '/profile',
            ),
            _buildMenuItem(
              context,
              Icons.contacts,
              'Emergency Contacts',
              '/emergency_contacts',
            ),
            _buildMenuItem(
              context,
              Icons.language,
              'Languages',
              '/languages',
            ),
            _buildMenuItem(
              context,
              Icons.contact_support,
              'Contact & Support',
              '/support',
            ),
            _buildMenuItem(
              context,
              Icons.security,
              'Safety Resources',
              '/safety_resources',
            ),
            _buildMenuItem(
              context,
              Icons.logout,
              'Logout',
              null,
              isLogout: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    String? route, {
    bool isLogout = false,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.blueAccent,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
          ),
        ),
        onTap: () {
          if (isLogout) {
            _showLogoutDialog(context);
          } else {
            // Navigate to the specified route
            Navigator.pushNamed(context, route!);
          }
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Logout',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          content: const Text(
            'Are you sure you want to log out?',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Logout',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              onPressed: () {
                // Perform actual logout logic, then navigate to login screen
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}
