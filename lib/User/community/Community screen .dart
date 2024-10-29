import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 3, 27, 88),
        elevation: 0,
        automaticallyImplyLeading: false, // Removes the back arrow
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Community Support',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background_image-removebg.png'), // Replace with your image path
                fit: BoxFit.cover, // Cover the entire screen
              ),
            ),
          ),
          // Faded Overlay
          Container(
            color: const Color.fromARGB(255, 249, 248, 248).withOpacity(0.5), // Adjust the opacity to control the fade
          ),
          // Foreground Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Report Case Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Call button
                    ElevatedButton.icon(
                      onPressed: () {
                        // Implement call functionality
                      },
                      icon: const Icon(Icons.call, color: Colors.white),
                      label: const Text(
                        'Call',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                    // Text button
                    ElevatedButton.icon(
                      onPressed: () {
                        // Implement text functionality
                      },
                      icon: const Icon(Icons.message, color: Colors.white),
                      label: const Text(
                        'Text',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Input Location Field
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Input Location',
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    suffixIcon: Icon(Icons.location_on, color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 20),
                // Check Police Availability Field
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Check Police Availability',
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    suffixIcon: Icon(Icons.map, color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 20),
                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    // Implement case submission functionality
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white, 
                      fontSize: 20.0, // Set text color to white
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  ),
                ),
                const SizedBox(height: 10),
                // Save Records Button
                ElevatedButton(
                  onPressed: () {
                    // Implement save records functionality
                  },
                  child: const Text(
                    'Save Records',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 20.0, // Set text color to white
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
