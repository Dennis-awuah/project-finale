import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PoliceScreen extends StatefulWidget {
  @override
  _PoliceDashboardState createState() => _PoliceDashboardState();
}

class _PoliceDashboardState extends State<PoliceScreen> {
  String? selectedLocation;
  String checkInStatus = '';
  String assignedDutyStatus = 'You have not been assigned to any duty yet.';
  String? assignedDutyLocation;

  final List<String> locations = ['Location 1', 'Location 2', 'Location 3'];

  @override
  void initState() {
    super.initState();
    _checkForAssignedDuty();
  }

  // Function to check if the officer has been assigned a duty
  Future<void> _checkForAssignedDuty() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      // Fetch assigned duty from Firestore based on the personnel ID
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('crime_reports')
          .where('assigned_officer', isEqualTo: currentUser.uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final crimeData = snapshot.docs.first.data() as Map<String, dynamic>;
        setState(() {
          assignedDutyLocation = crimeData['location'];
          assignedDutyStatus = 'Assigned to duty at: ${crimeData['location']}';
        });
      } else {
        setState(() {
          assignedDutyStatus = 'No assigned duty found.';
        });
      }
    }
  }

  void confirmLocation() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      setState(() {
        checkInStatus = 'Checked in at $selectedLocation';
      });

      // Update Firestore with check-in details
      await FirebaseFirestore.instance.collection('check-ins').doc(currentUser.uid).set({
        'personnel_id': currentUser.uid,
        'location': selectedLocation,
        'checked_in': true,
        'timestamp': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location confirmed: $selectedLocation')),
      );
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Check In At Post', style: TextStyle(color: Colors.black, fontFamily: 'Poppins')),
            ElevatedButton(
              onPressed: logout,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
              child: const Text('Logout', style: TextStyle(color: Colors.black, fontFamily: 'Poppins')),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_image-removebg.png'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Show a modal bottom sheet or dialog for selecting location
                _showLocationSelection();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedLocation ?? 'Check case location and verification',
                      style: const TextStyle(fontFamily: 'Poppins'),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: selectedLocation != null ? confirmLocation : null,
              icon: const Icon(Icons.location_on),
              label: const Text('Confirm Location', style: TextStyle(fontFamily: 'Poppins')),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              checkInStatus,
              style: const TextStyle(color: Colors.green, fontSize: 16, fontFamily: 'Poppins'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Assigned Duty:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
            ),
            const SizedBox(height: 10),
            Text(
              assignedDutyStatus,
              style: TextStyle(
                color: assignedDutyLocation != null ? Colors.blue : Colors.red,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLocationSelection() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: locations.map((location) {
              return ListTile(
                title: Text(location, style: const TextStyle(fontFamily: 'Poppins')),
                onTap: () {
                  setState(() {
                    selectedLocation = location;
                  });
                  Navigator.pop(context); // Close the bottom sheet
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
