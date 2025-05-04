import "package:flutter/material.dart";

class TodaysTask extends StatelessWidget {
  const TodaysTask({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Today",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 17, 16, 16)),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            //border: Border.all(color: Colors.black, width: 1),
          ),
          child: const Center(
            child: Text("No Tasks",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
          ),
        ),
      ],
    );
  }
}
