import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({
    super.key,
    required this.label,
    required this.amount,
    required this.icon,
    required this.gradientColors,
  });

  final String label;
  final String amount;
  final IconData icon;
  final List<Color> gradientColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.w,
      height: 110.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors.last.withValues(alpha: 0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 24.sp),
          SizedBox(height: 5.h),
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 12.sp),
          ),
          SizedBox(height: 2.h),
          Text(
            amount,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
