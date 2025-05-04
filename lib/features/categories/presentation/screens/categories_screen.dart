import "package:flutter/material.dart";

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: false,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth; // Parent's available width
            const spacing = 8.0;
            // Calculate card width: (parentWidth - spacing) / 2
            final cardWidth = (maxWidth - spacing) / 2;
        
            return Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              spacing: spacing,
              runSpacing: 4.0,
              children: List.generate(9, (index) {
                return CategoryCard(width: cardWidth);
              }),
            );
          },
        ),]
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final double width;

  const CategoryCard({
    super.key,
    required this.width,
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Home",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 17, 16, 16),
            ),
          ),
          Text(
            "12",
            style: TextStyle(
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
