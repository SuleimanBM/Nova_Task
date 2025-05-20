import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryCard extends StatelessWidget {
  final double width;
  final String category;
  final int count;

  const CategoryCard({
    super.key,
    required this.width,
    required this.category,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: width,
      padding: EdgeInsets.all(8.sp),
      // ✅ Remove horizontal margin
      margin: EdgeInsets.only(top: 4.h, bottom: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            category,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 17, 16, 16),
            ),
          ),
          Text(
            count.toString(),
            style:  TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 17, 16, 16),
            ),
          ),
        ],
      ),
    );
  }
}
