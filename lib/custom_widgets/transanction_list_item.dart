import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendsense/models/transaction_model.dart';
import 'package:intl/intl.dart';

// Helper function to get display properties (icon and color) based on category
Map<String, dynamic> getCategoryDisplay(String categoryId) {
  switch (categoryId) {
    case 'food':
      return {'icon': Icons.fastfood_outlined, 'color': Colors.red[400]};
    case 'bills':
      return {'icon': Icons.receipt_long_outlined, 'color': Colors.orange[400]};
    case 'transport':
      return {'icon': Icons.commute_outlined, 'color': Colors.indigo[400]};
    case 'shopping':
      return {'icon': Icons.shopping_bag_outlined, 'color': Colors.teal[400]};
    case 'salary':
      return {'icon': Icons.work_outline, 'color': Colors.green[400]};
    default:
      return {'icon': Icons.category_outlined, 'color': Colors.grey[400]};
  }
}

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({super.key, required this.transaction});

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
    );

    final displayProps = getCategoryDisplay(transaction.categoryId);
    final Color color = displayProps['color'] ?? Colors.grey;
    final IconData icon = displayProps['icon'] ?? Icons.error;
    final bool isIncome = transaction.type == 'income';

    final String titleToShow =
        (transaction.description != null &&
            transaction.description!.trim().isNotEmpty)
        ? transaction.description!
        : transaction.categoryName;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.1),
            ),
            child: Icon(icon, color: color, size: 22.sp),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleToShow,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  DateFormat('dd MMM yyyy').format(transaction.date.toDate()),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${isIncome ? '+' : '-'}${currencyFormat.format(transaction.amount)}",
            style: TextStyle(
              color: isIncome ? Colors.green.shade700 : Colors.red.shade700,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
