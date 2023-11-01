import 'package:e_commerce_app/common/cart_info.dart';
import 'package:e_commerce_app/common/settings.dart';
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
    final listView = ListView(
      children: listItemList,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Shopping Cart"),
      ),
      body: theresItems
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: listView,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: FilledButton(
                            onPressed: () async {
                              await showSuccesfulAlert(
                                context,
                                "You bought this thing!",
                                "Your receipt has been sended! you have to pay \$${CartInfo.getSubTotal().toStringAsFixed(2)} USD",
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                  "Buy Everything for \$${CartInfo.getSubTotal().toStringAsFixed(2)} USD"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
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
