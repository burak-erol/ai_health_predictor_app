import 'package:flutter/material.dart';
import 'package:health_score_app/test_view_1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'AI HEALTH PREDICTOR'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final verticalPadding = height < 700 ? 6.0 : 7.0;
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: verticalPadding * 5),
            Image.asset(
              'assets/logo.png',
              width: width * 0.75,
              height: height < 700 ? 150 : 300,
            ),
            Text(
              'Welcome to the AI Health Predictor',
              style: TextStyle(
                fontSize: height < 700 ? 18 : 22,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: verticalPadding * 5),
            SizedBox(
              width: width * 0.8,
              height: height < 700 ? 48 : 54,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TestView()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6CCB2E), Color(0xFF18B6B0)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: height < 700 ? 48 : 54,
                    child: Text(
                      'Start Health Assessment',
                      style: TextStyle(
                        fontSize: height < 700 ? 14 : 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: verticalPadding * 5),
          ],
        ),
      ),
    );
  }
}
