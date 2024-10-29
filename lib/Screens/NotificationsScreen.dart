import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String description;
  final String timestamp;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.description,
    required this.timestamp,
    this.isRead = false,
  });
}

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Sample notifications
  List<NotificationItem> notifications = [
    NotificationItem(
      title: 'Report Received',
      description: 'Your report regarding suspicious activity has been received.',
      timestamp: 'Today, 1:30 PM',
      isRead: false,
    ),
    NotificationItem(
      title: 'Safety Resources Updated',
      description: 'New safety resources are now available for your area.',
      timestamp: 'Yesterday, 10:00 AM',
      isRead: true,
    ),
    // Add more notifications here
  ];

  void _markAsRead(int index) {
    setState(() {
      notifications[index].isRead = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: notifications.isEmpty
          ? Center(
              child: Text(
                'No Notifications Yet!',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  color: notification.isRead ? Colors.grey[200] : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(
                      notification.isRead ? Icons.done : Icons.notifications,
                      color: notification.isRead ? Colors.grey : Colors.blueAccent,
                    ),
                    title: Text(
                      notification.title,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          notification.description,
                          style: const TextStyle(fontFamily: 'Poppins'),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          notification.timestamp,
                          style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                    trailing: notification.isRead
                        ? const SizedBox.shrink()
                        : TextButton(
                            child: const Text(
                              'Mark as Read',
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                            onPressed: () {
                              _markAsRead(index);
                            },
                          ),
                    onTap: () {
                      // Handle notification tap, e.g., view details
                      _showNotificationDetails(context, notification);
                    },
                  ),
                );
              },
            ),
    );
  }

  // Method to show details of a notification when tapped
  void _showNotificationDetails(BuildContext context, NotificationItem notification) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            notification.title,
            style: const TextStyle(fontFamily: 'Poppins'),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                notification.description,
                style: const TextStyle(fontFamily: 'Poppins'),
              ),
              const SizedBox(height: 10),
              Text(
                'Received at: ${notification.timestamp}',
                style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Poppins'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text(
                'Close',
                style: TextStyle(fontFamily: 'Poppins'),
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
