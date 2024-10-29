import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CrimeReportsScreen extends StatefulWidget {
  static const routeName = '/admin-dashboard';

  @override
  _CrimeReportsScreenState createState() => _CrimeReportsScreenState();
}

class _CrimeReportsScreenState extends State<CrimeReportsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<CrimeReport> _crimeReports = [];
  bool _isLoading = true;
  String? _selectedCrimeId; // Track the selected crime ID
  String _userName = ""; // Track the user name input

  @override
  void initState() {
    super.initState();
    _fetchCrimeReports();
  }

  Future<void> _fetchCrimeReports() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('crime_reports').get();
      setState(() {
        _crimeReports = querySnapshot.docs
            .map((doc) => CrimeReport.fromFirestore(doc))
            .toList();
        _isLoading = false;
      });
    } catch (error) {
      _showError('Error fetching crime reports: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _logout() async {
    await _auth.signOut();
    Navigator.of(context).pushReplacementNamed('/login');
  }

  void _verifyLocation() {
    // Implement location verification
    print('Location verified.');
  }

  Future<void> _assignUser() async {
    if (_selectedCrimeId != null && _userName.isNotEmpty) {
      try {
        await _firestore.collection('crime_reports').doc(_selectedCrimeId).update({
          'assigned_user': _userName, // Assign the typed user name
        });
        _showSnackBar('User assigned: $_userName');
      } catch (error) {
        _showError('Error assigning user: $error');
      }
    } else {
      _showError('Please select a crime report and enter a user name.');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red));
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.green));
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
            const SizedBox(), // Placeholder for center alignment
            const Text(
              'Check Crime And Monitor',
              style: TextStyle(color: Colors.black),
            ),
            ElevatedButton(
              onPressed: _logout,
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow,
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/background_image-removebg.png'), // Path to your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Assign User',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Colors.white, // Change text color for better visibility
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Enter User Name',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _userName = value; // Update user name
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Select Crime Index',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCrimeId = newValue; // Update selected crime ID
                          });
                        },
                        items: _crimeReports.map<DropdownMenuItem<String>>((crimeReport) {
                          return DropdownMenuItem<String>(
                            value: crimeReport.id, // Use the crime report ID
                            child: Text(crimeReport.crimeTitle ?? "Unknown Crime"),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: _verifyLocation,
                        icon: const Icon(Icons.location_on),
                        label: const Text(
                          'Verify Location',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_selectedCrimeId == null || _userName.isEmpty) {
                            _showError('Please select a crime report and enter a user name before proceeding.');
                          } else {
                            _assignUser();
                          }
                        },
                        child: const Text(
                          'Send',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: _crimeReports.isEmpty
                            ? const Center(child: Text('No crime reports found.'))
                            : ListView.builder(
                                itemCount: _crimeReports.length,
                                itemBuilder: (context, index) {
                                  return CrimeReportCard(crimeReport: _crimeReports[index]);
                                },
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

class CrimeReportCard extends StatelessWidget {
  final CrimeReport crimeReport;

  const CrimeReportCard({required this.crimeReport});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    crimeReport.crimeTitle ?? "No title available",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(Icons.report_gmailerrorred_outlined, color: Colors.redAccent),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.blueAccent),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      crimeReport.location ?? "No location available",
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(Icons.description, color: Colors.greenAccent),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      crimeReport.description ?? "No description available",
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(Icons.assignment, color: Colors.orange),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      crimeReport.status ?? "Status unknown",
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CrimeReport {
  final String id;
  final String? crimeTitle;
  final String? description;
  final String? location;
  final String? status;

  CrimeReport({
    required this.id,
    this.crimeTitle,
    this.description,
    this.location,
    this.status,
  });

  factory CrimeReport.fromFirestore(QueryDocumentSnapshot doc) {
    return CrimeReport(
      id: doc.id,
      crimeTitle: doc['crime_title'] as String?,
      description: doc['description'] as String?,
      location: doc['location'] as String?,
      status: doc['status'] as String?,
    );
  }
}
