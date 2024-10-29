import 'package:flutter/material.dart';

class Alert {
  final String title;
  final String description;
  final String imageUrl;
  final String timestamp;

  Alert({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.timestamp,
  });
}

class AlertsScreen extends StatelessWidget {
  // Sample alerts with titles, descriptions, and timestamps
  final List<Alert> alerts = [
    Alert(
      title: 'Suspicious Activity Reported',
      description: 'A suspicious activity was reported near Park Ave. at 4:23 PM. The authorities are investigating.',
      imageUrl: 'https://via.placeholder.com/150', // Replace with actual image URL
      timestamp: 'Today, 4:23 PM',
    ),
    Alert(
      title: 'Explosion in Industrial Area',
      description: 'An explosion was reported in the Industrial Area at 3:15 PM. Emergency services are on the scene.',
      imageUrl: 'https://via.placeholder.com/150', // Replace with actual image URL
      timestamp: 'Today, 3:15 PM',
    ),
    // Add more alerts here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFF5F5F5), // Light background color
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: alerts.length,
          itemBuilder: (context, index) {
            final alert = alerts[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white, // Set card color to white
                borderRadius: BorderRadius.circular(12), // Rounded corners for the card
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: ClipOval( // Rounded image
                  child: Image.network(
                    alert.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  alert.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins', // Apply Poppins font to the title
                    fontSize: 16,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      alert.description,
                      style: const TextStyle(
                        fontFamily: 'Poppins', // Apply Poppins font to the description
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      alert.timestamp,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontFamily: 'Poppins', // Apply Poppins font to the timestamp
                      ),
                    ),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blueAccent), // Trailing icon color
                onTap: () {
                  // Handle the tap for viewing alert details
                  _showAlertDetails(context, alert);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  // Method to show details of an alert when tapped
  void _showAlertDetails(BuildContext context, Alert alert) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            alert.title,
            style: const TextStyle(
              fontFamily: 'Poppins', // Apply Poppins font to the title
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView( // Scrollable content
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(alert.imageUrl),
                const SizedBox(height: 10),
                Text(
                  alert.description,
                  style: const TextStyle(
                    fontFamily: 'Poppins', // Apply Poppins font to the description
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Reported at:',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      alert.timestamp,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontFamily: 'Poppins', // Apply Poppins font to the timestamp
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Close',
                style: TextStyle(
                  fontFamily: 'Poppins', // Apply Poppins font to the button
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
