// lib/models/crime_report.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class CrimeReport {
  final String id;
  final String description;
  final String location;
  final DateTime dateReported;
  final String reportedBy;

  CrimeReport({
    required this.id,
    required this.description,
    required this.location,
    required this.dateReported,
    required this.reportedBy,
  });

  factory CrimeReport.fromFirestore(Map<String, dynamic> data, String documentId) {
    return CrimeReport(
      id: documentId,
      description: data['description'] ?? 'No Description',
      location: data['location'] ?? 'Unknown Location',
      dateReported: (data['dateReported'] as Timestamp?)?.toDate() ?? DateTime.now(),
      reportedBy: data['reportedBy'] ?? 'Anonymous',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'description': description,
      'location': location,
      'dateReported': dateReported,
      'reportedBy': reportedBy,
    };
  }
}
