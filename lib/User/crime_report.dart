// lib/screens/crime_reports_screen.dart
import 'package:flutter/material.dart';
import 'package:police_app/model/crime_report.dart';
import 'package:police_app/provider/crime_reports_provider.dart';
import 'package:provider/provider.dart';


class CrimeReportsScreen extends StatefulWidget {
  @override
  _CrimeReportsScreenState createState() => _CrimeReportsScreenState();
}

class _CrimeReportsScreenState extends State<CrimeReportsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch crime reports when the screen initializes
    Future.microtask(() =>
        Provider.of<CrimeReportsProvider>(context, listen: false)
            .fetchCrimeReports());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crime Reports'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Provider.of<CrimeReportsProvider>(context, listen: false)
                  .fetchCrimeReports();
            },
          ),
        ],
      ),
      body: Consumer<CrimeReportsProvider>(
        builder: (context, crimeReportsProvider, child) {
          if (crimeReportsProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (crimeReportsProvider.errorMessage != null) {
            return Center(child: Text(crimeReportsProvider.errorMessage!));
          }

          final List<CrimeReport> reports = crimeReportsProvider.crimeReports;

          if (reports.isEmpty) {
            return Center(child: Text('No crime reports available.'));
          }

          return RefreshIndicator(
            onRefresh: crimeReportsProvider.fetchCrimeReports,
            child: ListView.builder(
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final CrimeReport report = reports[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 3,
                  child: ListTile(
                    title: Text(report.description),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Location: ${report.location}'),
                        SizedBox(height: 5),
                        Text('Reported By: ${report.reportedBy}'),
                        SizedBox(height: 5),
                        Text('Date: ${report.dateReported.toLocal().toString().split(' ')[0]}'),
                      ],
                    ),
                    // Optional: Add more details or actions
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Optional: Add functionality to add a new crime report
        },
        child: Icon(Icons.add),
        tooltip: 'Add Crime Report',
      ),
    );
  }
}
