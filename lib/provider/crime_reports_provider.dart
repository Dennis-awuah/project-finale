// lib/providers/crime_reports_provider.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:police_app/model/crime_report.dart';


class CrimeReportsProvider with ChangeNotifier {
  List<CrimeReport> _crimeReports = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<CrimeReport> get crimeReports => _crimeReports;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch crime reports from Firestore
  Future<void> fetchCrimeReports() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('crime_reports').orderBy('dateReported', descending: true).get();

      _crimeReports = querySnapshot.docs.map((doc) {
        return CrimeReport.fromFirestore(doc.data()! as Map<String, dynamic>, doc.id);
      }).toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error fetching crime reports: $e");
      _errorMessage = "Failed to load crime reports.";
      _crimeReports = [];
      _isLoading = false;
      notifyListeners();
    }
  }

  
}
