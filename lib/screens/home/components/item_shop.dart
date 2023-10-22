import 'package:e_commerce_app/common/DTO/item_shop_data.dart';
import 'package:e_commerce_app/screens/article/article.dart';
import 'package:flutter/material.dart';

class ItemShop extends StatefulWidget {
  final ItemShopData data;
  final double paddingSize;
  final double width;
  final double height;
  const ItemShop({
    super.key,
    required this.data,
    this.paddingSize = 10,
    this.width = 200,
    this.height = 250,
  });

  @override
  State<ItemShop> createState() => _ItemShopState();
}

class _ItemShopState extends State<ItemShop> {
  Image? image;

  Future<void> gettingImage() async {
    // ignore: await_only_futures
    image = await Image.network(
      widget.data.image,
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    gettingImage();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.paddingSize),
      child: SizedBox(
        // height: height,
        width: widget.width,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArticleScreen(data: widget.data)));
          },
          child: Card(
            elevation: 4.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProductImage(
                    paddingSize: widget.paddingSize,
                    width: widget.width,
                    itemPic: image),
                ProductTitle(
                    paddingSize: widget.paddingSize,
                    productName: widget.data.title),
                PriceLabel(
                    paddingSize: widget.paddingSize, price: widget.data.price)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PriceLabel extends StatelessWidget {
  const PriceLabel({
    super.key,
    required this.paddingSize,
    required this.price,
  });

  final double paddingSize;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(paddingSize),
      child: Row(
        children: [
          const Expanded(child: Row()),
          Text(
            "\$${price.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 20, color: Colors.green.shade500),
          )
        ],
      ),
    );
  }
}

class ProductTitle extends StatelessWidget {
  const ProductTitle({
    super.key,
    required this.paddingSize,
    required this.productName,
  });

  final double paddingSize;
  final String productName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingSize),
      child: Text(
        productName,
        style: const TextStyle(fontSize: 16),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage(
      {super.key,
      required this.paddingSize,
      required this.width,
      this.itemPic});

  final double paddingSize;
  final double width;
  final Image? itemPic;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(paddingSize),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.white,
          child: SizedBox(
            width: width - (paddingSize * 2),
            height: width - (paddingSize * 2),
            child: itemPic ?? const LoadingImage(),
          ),
        ),
      ),
    );
  }
}

class LoadingImage extends StatelessWidget {
  const LoadingImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CircularProgressIndicator(
          backgroundColor: Colors.grey.shade200,
        ),
      ),
    );
  }
}
