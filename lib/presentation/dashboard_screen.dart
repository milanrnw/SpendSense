import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendsense/presentation/add_new_transaction.dart';
import 'package:spendsense/presentation/home_screen.dart';
import 'package:spendsense/presentation/report_screen.dart';
import 'package:spendsense/presentation/setting_screen.dart';
import 'package:spendsense/presentation/transaction_history.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const TransactionHistory(),
    const ReportScreen(),
    const SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color secondaryColor = Color(0xFF80C0E2);
    const Color unselectedColor = Colors.grey;

    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButton: Container(
        width: 70.w,
        height: 70.h,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFFA9E5B7), Color(0xFF80C0E2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: FloatingActionButton(
          heroTag: 'add_transaction_fab',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNewTransaction(),
              ),
            );
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ADD",
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "TRANSACTION",
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildNavItem(
              icon: Icons.dashboard_outlined,
              label: "Dashboard",
              index: 0,
              color: _selectedIndex == 0 ? secondaryColor : unselectedColor,
            ),
            _buildNavItem(
              icon: Icons.playlist_add_check_circle_outlined,
              label: "Transactions",
              index: 1,
              color: _selectedIndex == 1 ? secondaryColor : unselectedColor,
            ),
            const SizedBox(width: 40),
            _buildNavItem(
              icon: Icons.bar_chart_outlined,
              label: "Reports",
              index: 2,
              color: _selectedIndex == 2 ? secondaryColor : unselectedColor,
            ),
            _buildNavItem(
              icon: Icons.settings_outlined,
              label: "Settings",
              index: 3,
              color: _selectedIndex == 3 ? secondaryColor : unselectedColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required Color color,
  }) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      customBorder: const CircleBorder(),
      child: Container(
        width: 70.w,
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24.sp),
            SizedBox(height: 2.h),
            Text(
              label,
              style: TextStyle(color: color, fontSize: 12.sp),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
