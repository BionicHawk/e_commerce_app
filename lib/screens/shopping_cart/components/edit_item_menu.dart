import 'package:e_commerce_app/common/cart_info.dart';
import 'package:e_commerce_app/common/settings.dart';
import 'package:flutter/material.dart';

class EditItemMenu extends StatefulWidget {
  const EditItemMenu({super.key, required this.item, this.onDispose});

  final ShopingItem item;
  final VoidCallback? onDispose;

  @override
  State<EditItemMenu> createState() => _EditItemMenuState();
}

class _EditItemMenuState extends State<EditItemMenu> {
  int quantity = 0;

  void onAdd() {
    setState(() {
      quantity++;
    });
  }

  void onLess() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.onDispose;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      quantity = widget.item.quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    const header = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: Icon(Icons.edit),
        ),
        Text(
          "Edit item delivery",
          style: TextStyle(fontSize: 18),
        )
      ],
    );

    const divider = Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(),
    );

    double getPreCost() {
      return widget.item.item.price * quantity;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: header,
        ),
        divider,
        BriefInfo(
          src: widget.item.item.image,
          articleName: widget.item.item.title,
          price: widget.item.item.price,
        ),
        divider,
        Buttons(
          quantity: quantity,
          onAdd: () {
            onAdd();
          },
          onLess: () {
            onLess();
          },
        ),
        divider,
        SubTotalTag(cost: getPreCost()),
        divider,
        ProcedureButtons(
          onNext: () {
            widget.item.quantity = quantity;
            Navigator.of(context).pop();
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}

class BriefInfo extends StatelessWidget {
  const BriefInfo(
      {super.key,
      required this.src,
      required this.articleName,
      required this.price});

  final String src;
  final String articleName;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.white,
                width: 64,
                height: 64,
                child: Image.network(src),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textDelimiter(articleName, 30),
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "\$${price.toStringAsFixed(2)} USD",
                style: TextStyle(fontSize: 18, color: Colors.green.shade700),
              )
            ],
          )
        ],
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({super.key, required this.quantity, this.onAdd, this.onLess});

  final int quantity;
  final VoidCallback? onAdd;
  final VoidCallback? onLess;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: FloatingActionButton(
              onPressed: onLess,
              shape: const CircleBorder(),
              child: const Icon(Icons.exposure_minus_1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: FloatingActionButton(
              onPressed: onAdd,
              shape: const CircleBorder(),
              child: const Icon(Icons.plus_one),
            ),
          ),
          Text(
            "$quantity pieces",
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}

class SubTotalTag extends StatelessWidget {
  const SubTotalTag({super.key, required this.cost});
  final double cost;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "\$${cost.toStringAsFixed(2)} USD",
          style: TextStyle(fontSize: 18, color: Colors.green.shade700),
        ),
      ),
    );
  }
}

class ProcedureButtons extends StatelessWidget {
  const ProcedureButtons({super.key, this.onCancel, this.onNext});

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
                  onPressed: onNext, child: const Text("Modify")),
            ))
      ],
    );
  }
}