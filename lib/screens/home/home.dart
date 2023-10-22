import 'package:dio/dio.dart';
import 'package:e_commerce_app/common/DTO/item_shop_data.dart';
import 'package:e_commerce_app/common/settings.dart';
import 'package:e_commerce_app/screens/home/components/item_shop.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool gotItems = false;
  double sizeForItems = 0.0;
  List<ItemShop> items = List.empty(growable: true);

  Future<void> getItems() async {
    String url = "https://fakestoreapi.com/products";
    List<dynamic>? responseData;
    List<ItemShopData> dataItems = List.empty(growable: true);

    var response = await Dio().get(url);
    if (response.statusCode == 200) {
      responseData = response.data;

      for (var data in responseData!) {
        dataItems.add(ItemShopData.fromJson(data));
      }

      for (var data in dataItems) {
        items.add(ItemShop(
          data: data,
          width: sizeForItems,
        ));
      }

      gotItems = true;

      setState(() {});
    } else {}
  }

  @override
  void initState() {
    lockScreen(true);
    super.initState();
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    sizeForItems = (MediaQuery.of(context).size.width * 0.5) - 20;

    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.shopify_rounded),
          title: const Text("ShopHere"),
        ),
        body: gotItems
            ? GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.71,
                children: items,
              )
            : const Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("Gathering items..."),
                  )
                ],
              )));
  }
}
