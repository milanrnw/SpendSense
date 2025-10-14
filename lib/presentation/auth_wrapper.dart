import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendsense/authentication/login_screen.dart';
import 'package:spendsense/presentation/dashboard_screen.dart';
import 'package:spendsense/providers/auth_provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (authProvider.user != null) {
          return const DashboardScreen();
        }

        return const LoginScreen();
      },
    );
  }
}
