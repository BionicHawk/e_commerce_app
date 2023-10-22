import 'package:e_commerce_app/common/DTO/item_shop_data.dart';
import 'package:flutter/material.dart';

class MainArticleInfo extends StatelessWidget {
  const MainArticleInfo({
    super.key,
    required this.data,
    required this.specialPadding,
  });

  final ItemShopData data;
  final EdgeInsetsGeometry specialPadding;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        ArticleName(name: data.title, price: data.price),
        MetaData(
            specialPadding: specialPadding,
            category: data.category,
            rating: data.rating),
      ]),
    );
  }
}

class MetaData extends StatelessWidget {
  const MetaData(
      {super.key,
      required this.specialPadding,
      required this.category,
      required this.rating});

  final EdgeInsetsGeometry specialPadding;
  final String category;
  final Rating rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: specialPadding,
          child: Text("Category: $category"),
        ),
        Padding(
          padding: specialPadding,
          child: Text(
            "Sells: ${rating.count}   Rating: ${rating.rate}/5",
            style: TextStyle(color: Colors.green.shade600),
          ),
        )
      ],
    );
  }
}

class ArticleName extends StatelessWidget {
  const ArticleName({super.key, required this.name, required this.price});

  final String name;
  final double price;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: height > width ? width * 0.55 : width * 0.75,
          child: Text(
            name,
            style: const TextStyle(fontSize: 24),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      const Expanded(child: Row()),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "\$$price USD",
          style: TextStyle(fontSize: 24, color: Colors.green.shade600),
        ),
      )
    ]);
  }
}
