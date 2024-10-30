import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(
    const BloodPressureApp(),
  );
}

class BloodPressureApp extends StatelessWidget {
  const BloodPressureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Pressure Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: HomePage(),
      ),
    );
  }
}
