import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report an Incident"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Incident Details'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle video upload
                  },
                  icon: const Icon(Icons.video_call),
                  label: const Text('Upload Video'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle picture upload
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text('Upload Picture'),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Handle Submit
              },
              child: const Text('Submit Tip'),
            ),
          ],
        ),
      ),
    );
  }
}
