import "package:flutter/material.dart";

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
      height: 200,
      width: width,
      padding: const EdgeInsets.all(8),
      // ✅ Remove horizontal margin
      margin: const EdgeInsets.only(top: 4, bottom: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            category,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 17, 16, 16),
            ),
          ),
          Text(
            count.toString(),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 17, 16, 16),
            ),
          ),
        ],
      ),
    );
  }
}
