// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:consolelovers/Model/Gamer.dart';
import 'package:consolelovers/Model/Product.dart';

class Order {
  String orderID;
  Gamer gamer;
  String orderPhoneNumber;
  String orderAdress;
  List<Product> productList;
  int orderPrice;
  Order({
    required this.orderID,
    required this.gamer,
    required this.orderPhoneNumber,
    required this.orderAdress,
    required this.productList,
    required this.orderPrice,
  });

  @override
  String toString() {
    return 'Order(orderID: $orderID, gamer: $gamer, orderPhoneNumber: $orderPhoneNumber, orderAdress: $orderAdress, productList: $productList, orderPrice: $orderPrice)';
  }
}
