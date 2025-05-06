import "package:flutter/material.dart";


class Statistics extends StatelessWidget {
  const Statistics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Row(children: [
              Icon(
                Icons.check_circle,
                size: 20,
              ),
              const Text(
                "Completed",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 17, 16, 16)),
              ),
            ]),
            const Text(
              "2494",
              style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 17, 16, 16)),
            ),
          ]),
          Column(children: [
            Row(children: [
              Icon(
                Icons.timer,
                size: 20,
              ),
              const Text(
                "Pending",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 17, 16, 16)),
              ),
            ]),
            const Text(
              "2874",
              style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 17, 16, 16)),
            ),
          ]),
          Column(children: [
            Row(children: [
              Icon(
                Icons.error_sharp,
                size: 20,
              ),
              const Text(
                "Overdue",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 17, 16, 16)),
              ),
            ]),
            const Text(
              "2334",
              style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 17, 16, 16)),
            ),
          ])
        ]);
  }
}
