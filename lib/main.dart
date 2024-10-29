import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview/device_preview.dart';
import 'package:police_app/User/community/Community%20Personal.dart';
import 'package:police_app/provider/crime_reports_provider.dart';
import 'package:provider/provider.dart'; // Import Provider package
import 'package:police_app/User/admin/admin.dart';

import 'package:police_app/User/police/police.dart';
import 'signup_screen.dart';
import 'login_screen.dart';
import 'home_screen.dart';


const FirebaseOptions firebaseOptions = FirebaseOptions(
  apiKey: "AIzaSyDy496WIsIxmPG7_zsvojqllOMBFLT4A38",
  appId: "1:439093931907:android:e261d186c1a4133a3b50b6",
  messagingSenderId: "439093931907",
  projectId: "police1-cb227",
  storageBucket: "police1-cb227.appspot.com",
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (kIsWeb || (!defaultTargetPlatform.toString().contains('Android') && !defaultTargetPlatform.toString().contains('iOS'))) {
      await Firebase.initializeApp(
        options: firebaseOptions,
      );
    } else {
      await Firebase.initializeApp();
    }

    runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => ChangeNotifierProvider(
          create: (_) => CrimeReportsProvider(), // Provide CrimeReportsProvider
          child: MyApp(),
        ),
      ),
    );
  } catch (e) {
    print("Firebase initialization error: $e");
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Community Policing App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
        '/communityDashboard': (context) => CommunityDashboard(),
        '/policeDashboard': (context) => PoliceDashboard(),
        '/adminDashboard': (context) => AdminDashboard(),
      },
    );
  }
}
