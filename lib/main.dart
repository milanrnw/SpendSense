import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendsense/authentication/login_screen.dart';
import 'package:spendsense/firebase_options.dart';
import 'package:spendsense/presentation/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Using ScreenUtilInit for responsive UI design
    return ScreenUtilInit(
      designSize: const Size(390, 844), // iPhone 12 Pro dimensions as a base
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SpendSense',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Poppins', // Assuming you have a default font
          ),
          home: FirebaseAuth.instance.currentUser != null
              ? DashboardScreen()
              : LoginScreen(),
        );
      },
    );
  }
}
