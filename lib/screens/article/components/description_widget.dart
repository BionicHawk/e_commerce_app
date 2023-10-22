import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget(
      {super.key, required this.articleName, required this.articleDescription});

  final String articleName;
  final String articleDescription;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "Description",
              style: TextStyle(fontSize: 24),
            ),
          ),
          const Divider(),
          Text(
            "Complete Article Name: $articleName",
            style: const TextStyle(
                fontSize: 16,
                color: Colors.purple,
                fontWeight: FontWeight.bold),
          ),
          Text(
            articleDescription,
            style: const TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
