import 'DTO/item_shop_data.dart';

class CartInfo {
  
  static List<ShopingItem> shopingList = List.empty(growable: true);

  static double getSubTotal() {
    double subTotal = 0;

    for (var item in shopingList) {
      subTotal += item.getCost();
    }

    return subTotal;

  }

  static void addOrUpdateItem(ItemShopData item, int quantity) {

    if (shopingList.isNotEmpty) {

      ShopingItem? sItem;

      for (var shopingItem in shopingList) {

        if (shopingItem.item == item) sItem = shopingItem;

      }

      if (sItem != null) {

        sItem.quantity = quantity;

      } else {

        shopingList.add(ShopingItem(item: item, quantity: quantity));

      }

    } else {

      shopingList.add(ShopingItem(item: item, quantity: quantity));

    }

    shopingList;

  }

  static ShopingItem? getMatch(ItemShopData item) {

    for (var shopingItem in shopingList) {
      if (shopingItem.item == item) return shopingItem;
    }

    return null;

  }

}

class ShopingItem {

  final ItemShopData item;
  int quantity;

  ShopingItem({required this.item, required this.quantity});

  double getCost() => quantity * item.price;

  void addOneMore() => quantity++;

  void substractOneMore() {
    if (quantity > 0) quantity--;
  }

}