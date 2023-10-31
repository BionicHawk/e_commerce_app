import 'package:e_commerce_app/common/cart_info.dart';
import 'package:e_commerce_app/screens/shopping_cart/components/item_list.dart';
import 'package:flutter/material.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  bool theresItems = false;
  List<ItemList> listItemList = List.empty(growable: true);

  void verifyIfTheresAnyItems() {
    if (CartInfo.shopingList.isNotEmpty) {
      theresItems = true;
    }

    for (var item in CartInfo.shopingList) {
      listItemList.add(ItemList(
        item: item,
        whenMenuOff: () {
          initState();
        },
      ));
    }

    setState(() {});
  }

  @override
  void initState() {
    verifyIfTheresAnyItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Shopping Cart"),
      ),
      body: theresItems
          ? ListView(
              children: listItemList,
            )
          : const Center(
              child: Text(
                "There's not any item in this list!",
                style: TextStyle(fontSize: 20),
              ),
            ),
    );
  }
}
