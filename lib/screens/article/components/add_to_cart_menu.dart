import 'package:e_commerce_app/common/DTO/item_shop_data.dart';
import 'package:e_commerce_app/common/cart_info.dart';
import 'package:e_commerce_app/common/settings.dart';
import 'package:flutter/material.dart';

class AddToCartMenu extends StatefulWidget {
  const AddToCartMenu({super.key, required this.item});

  final ItemShopData item;

  @override
  State<AddToCartMenu> createState() => _AddToCartMenuState();
}

class _AddToCartMenuState extends State<AddToCartMenu> {
  String finalName = "";
  int quantity = 1;
  double subTotal = 0;

  void updatePrice() {
    subTotal = widget.item.price * quantity;
  }

  void addOneMore() {
    setState(() {
      quantity++;
      updatePrice();
    });
  }

  void quitOne() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        updatePrice();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {

      if (CartInfo.shopingList.isNotEmpty) {

        var match = CartInfo.getMatch(widget.item);

        if (match != null) quantity = match.quantity;

      }

      updatePrice();
    });
  }

  @override
  Widget build(BuildContext context) {
    void quitMenu() {
      Navigator.of(context).pop(context);
    }

    void addToCart() {
      CartInfo.addOrUpdateItem(widget.item, quantity);
      Navigator.of(context).pop(context);
    }

    const header = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.shopping_cart),
        Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
        Text(
          "Add in my shopping cart",
          style: TextStyle(fontSize: 24),
        )
      ],
    );

    const divider = Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(),
    );

    return Column(
      children: [
        const Padding(padding: EdgeInsets.all(8.0), child: header),
        divider,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BriefInfo(
            articleName: textDelimiter(widget.item.title, 30),
            price: widget.item.price,
            imageSrc: widget.item.image,
          ),
        ),
        divider,
        QuantityOption(
          quantity: quantity,
          onAdd: () {
            addOneMore();
          },
          onLess: () {
            quitOne();
          },
        ),
        divider,
        SubTotalInfo(
          subTotal: subTotal,
        ),
        Buttons(
          onCancel: () {
            quitMenu();
          },
          onNext: () {
            addToCart();
          },
        )
      ],
    );
  }
}

class BriefInfo extends StatelessWidget {
  const BriefInfo(
      {super.key,
      required this.articleName,
      required this.price,
      required this.imageSrc});

  final String articleName;
  final double price;
  final String imageSrc;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: 64, height: 64, child: Image.network(imageSrc)),
            )),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              articleName,
              style: const TextStyle(
                  fontSize: 18, overflow: TextOverflow.ellipsis),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              "\$${price} USD",
              style: const TextStyle(color: Colors.green, fontSize: 18),
            )
          ],
        ),
      )
    ]);
  }
}

class QuantityOption extends StatelessWidget {
  const QuantityOption({super.key, this.quantity = 0, this.onAdd, this.onLess});

  final int quantity;
  final VoidCallback? onAdd;
  final VoidCallback? onLess;

  @override
  Widget build(BuildContext context) {
    final addBtn = FloatingActionButton(
        onPressed: onAdd,
        shape: const CircleBorder(),
        child: const Icon(Icons.plus_one));

    final substractBtn = FloatingActionButton(
        onPressed: onLess,
        shape: const CircleBorder(),
        child: const Icon(Icons.exposure_minus_1));

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: substractBtn,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: addBtn,
        ),
        Text(
          "$quantity pieces",
          style: const TextStyle(fontSize: 18),
        )
      ],
    );
  }
}

class SubTotalInfo extends StatelessWidget {
  const SubTotalInfo({super.key, this.subTotal = 0.0});

  final double subTotal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          "Subtotal: \$${subTotal.toStringAsFixed(2)} USD",
          style: TextStyle(fontSize: 18, color: Colors.green.shade800),
        ),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({super.key, this.onCancel, this.onNext});

  final VoidCallback? onCancel;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              ElevatedButton(onPressed: onCancel, child: const Text("Cancel")),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FilledButton(
              onPressed: onNext, child: const Text("Add in the cart")),
        ))
      ],
    );
  }
}
