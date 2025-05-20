import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Statistics extends StatelessWidget {
  final String completed;
  final String pending;
  final String overdue;

  Statistics({
    super.key,
    required this.completed,
    required this.pending,
    required this.overdue
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Row(children: [
              Icon(
                Icons.check_circle,
                size: 20.sp,
              ),
               Text(
                "Completed",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 17, 16, 16)),
              ),
            ]),
            Text(
              completed ?? "0",
              style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 17, 16, 16)),
            ),
          ]),
          Column(children: [
            Row(children: [
              Icon(
                Icons.timer,
                size: 20.sp,
              ),
              Text(
                "Pending",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 17, 16, 16)),
              ),
            ]),
            Text(
              pending?? "0",
              style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 17, 16, 16)),
            ),
          ]),
          Column(children: [
            Row(children: [
              Icon(
                Icons.error_sharp,
                size: 20.sp,
              ),
              Text(
                "Overdue",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 17, 16, 16)),
              ),
            ]),
            Text(
              overdue?? "0",
              style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 17, 16, 16)),
            ),
          ])
        ]);
  }
}
