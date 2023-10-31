import 'package:flutter/material.dart';

class AddToCartBtn extends StatelessWidget {
  const AddToCartBtn({super.key, this.function});

  final VoidCallback? function;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: function,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart),
            Text("Add in my Shopping Cart")
          ],
        ));
  }
}
