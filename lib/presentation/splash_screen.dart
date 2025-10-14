import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendsense/authentication/login_screen.dart';
import 'package:spendsense/presentation/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    Timer(const Duration(seconds: 3), () {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // If user is already logged in, go to Dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      } else {
        // If no user is logged in, go to Login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png", // Make sure you have this asset
              height: 150.h,
              width: 150.w,
            ),
            SizedBox(height: 20.h),
            Text(
              "SpendSense",
              style: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1B3253),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Your Path to Financial Peace",
              style: TextStyle(fontSize: 20.sp, color: const Color(0xFF80C0E2)),
            ),
            SizedBox(height: 40.h),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF80C0E2)),
            ),
          ],
        ),
      ),
    );
  }
}
