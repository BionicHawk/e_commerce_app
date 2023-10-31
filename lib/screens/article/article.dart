import 'dart:ffi';

import 'package:e_commerce_app/common/DTO/item_shop_data.dart';
import 'package:e_commerce_app/common/settings.dart';
import 'package:e_commerce_app/screens/article/components/add_to_cart.dart';
import 'package:e_commerce_app/screens/article/components/add_to_cart_menu.dart';
import 'package:e_commerce_app/screens/article/components/description_widget.dart';
import 'package:e_commerce_app/screens/article/components/loading_widget.dart';
import 'package:e_commerce_app/screens/article/components/main_article_info.dart';
import 'package:flutter/material.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key, required this.data});

  final ItemShopData data;

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  Image? image;

  Future<void> getImage() async {
    // ignore: await_only_futures
    image = await Image.network(widget.data.image);
    setState(() {});
  }

  @override
  void initState() {
    lockScreen(false);
    super.initState();
    getImage();
  }

  @override
  void dispose() {
    lockScreen(true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry specialPadding =
        const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0);

    void showCartMenu() {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) => SizedBox(
                child: AddToCartMenu(item: widget.data),
              ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.title),
      ),
      body: ListView(children: [
        SizedBox(
          height: 300,
          child: Container(
              color: image == null ? Colors.grey.shade700 : Colors.white,
              child: image ?? const LoadingWidget()),
        ),
        MainArticleInfo(
          data: widget.data,
          specialPadding: specialPadding,
        ),
        DescriptionWidget(
          articleName: widget.data.title,
          articleDescription: widget.data.description,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: AddToCartBtn(
            function: () {
              print("Trying to open menu...");
              showCartMenu();
            },
          ),
        )
      ]),
    );
  }
}
