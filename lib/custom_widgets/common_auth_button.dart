import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonAuthButton extends StatelessWidget {
  const CommonAuthButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.backgroundColor,
    this.isLoading = false,
  });

  final String buttonText;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            offset: const Offset(2, 2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: SizedBox(
        width: 294.w,
        height: 52.h,
        child: ElevatedButton(
          // Disable the button when loading
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.w),
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                )
              : Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
