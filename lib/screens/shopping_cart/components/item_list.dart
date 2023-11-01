// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_app/common/cart_info.dart';
import 'package:e_commerce_app/screens/shopping_cart/shopping_cart_screen.dart';
import 'package:flutter/material.dart';

import '../../../common/settings.dart';
import 'edit_item_menu.dart';

class ItemList extends StatelessWidget {
  const ItemList({super.key, required this.item, this.whenMenuOff});

  final ShopingItem item;
  final VoidCallback? whenMenuOff;

  void DeleteThis() {
    CartInfo.shopingList.remove(item);
  }

  @override
  Widget build(BuildContext context) {
    final image = Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.white,
          width: 64,
          height: 64,
          child: Image.network(item.item.image),
        ),
      ),
    );

    final briefInfo = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textDelimiter(item.item.title, 14),
          style: const TextStyle(fontSize: 18),
        ),
        Text("${item.quantity} pieces"),
        Text(
          "Cost: \$${item.getCost().toStringAsFixed(2)} USD",
          style: TextStyle(color: Colors.green.shade700),
        )
      ],
    );

    Future<void> showEditItemMenu() async {
      await showModalBottomSheet(
          context: context,
          builder: (context) {
            return EditItemMenu(item: item, onDispose: () {
              print("Executing...");
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ShoppingCartScreen()));
            },);
          });
    }

    return SizedBox(
      height: 80,
      child: Card(
        child: Row(
          children: [
            image,
            briefInfo,
            const Expanded(child: Row()),
            Row(
              children: [
                CartButton(
                    icon: Icons.edit,
                    function: () async {
                      await showEditItemMenu();
                      Navigator.of(context).pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ShoppingCartScreen()));
                    }),
                CartButton(
                  icon: Icons.delete,
                  function: () {
                    DeleteThis();
                    Navigator.of(context).pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ShoppingCartScreen()));
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CartButton extends StatelessWidget {
  const CartButton({super.key, required this.icon, this.function});

  final IconData icon;
  final VoidCallback? function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        onPressed: function,
        shape: const CircleBorder(),
        elevation: 1.0,
        child: Icon(icon),
      ),
    );
  }
}
