import "package:flutter/material.dart";

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
            const Row(children: [
              Icon(
                Icons.check_circle,
                size: 20,
              ),
               Text(
                "Completed",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 17, 16, 16)),
              ),
            ]),
            Text(
              completed,
              style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 17, 16, 16)),
            ),
          ]),
          Column(children: [
            const Row(children: [
              Icon(
                Icons.timer,
                size: 20,
              ),
              Text(
                "Pending",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 17, 16, 16)),
              ),
            ]),
            Text(
              pending,
              style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 17, 16, 16)),
            ),
          ]),
          Column(children: [
            const Row(children: [
              Icon(
                Icons.error_sharp,
                size: 20,
              ),
              Text(
                "Overdue",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 17, 16, 16)),
              ),
            ]),
            Text(
              overdue,
              style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 17, 16, 16)),
            ),
          ])
        ]);
  }
}
