import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Community Alerts"),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Handle menu
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.warning, color: Colors.red),
            title: Text("Incident #$index"),
            subtitle: const Text("Details about this incident..."),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to detail
            },
          );
        },
      ),
    );
  }
}
