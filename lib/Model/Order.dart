// ignore_for_file: public_member_api_docs, sort_constructors_firs
import 'package:consolelovers/Model/Product.dart';
import 'package:consolelovers/Model/ProductInBasket.dart';

class Order {
  String orderID;
  String gamerID;
  String gamerName;
  String gamerSurname;
  String gamerPhoneNumber;
  String gamerAdress;
  List<Product> productList;
  int orderPrice;

  Order({
    required this.orderID,
    required this.gamerID,
    required this.gamerName,
    required this.gamerSurname,
    required this.gamerPhoneNumber,
    required this.gamerAdress,
    required this.productList,
    required this.orderPrice,
  });

  Order copyWith({
    String? orderID,
    String? gamerID,
    String? gamerName,
    String? gamerSurname,
    String? gamerPhoneNumber,
    String? gamerAdress,
    List<Product>? productList,
    int? orderPrice,
  }) {
    return Order(
      orderID: orderID ?? this.orderID,
      gamerID: gamerID ?? this.gamerID,
      gamerName: gamerName ?? this.gamerName,
      gamerSurname: gamerSurname ?? this.gamerSurname,
      gamerPhoneNumber: gamerPhoneNumber ?? this.gamerPhoneNumber,
      gamerAdress: gamerAdress ?? this.gamerAdress,
      productList: productList ?? this.productList,
      orderPrice: orderPrice ?? this.orderPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderID': orderID,
      'gamerID': gamerID,
      'gamerName': gamerName,
      'gamerSurname': gamerSurname,
      'gamerPhoneNumber': gamerPhoneNumber,
      'gamerAdress': gamerAdress,
      'productList': productList.map((x) => x.toMap()).toList(),
      'orderPrice': orderPrice,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      orderID: map['orderID'] as String,
      gamerID: map['gamerID'] as String,
      gamerName: map['gamerName'] as String,
      gamerSurname: map['gamerSurname'] as String,
      gamerPhoneNumber: map['gamerPhoneNumber'] as String,
      gamerAdress: map['gamerAdress'] as String,
      productList: List<ProductInBasket>.from(
        (map['productList'] as List<dynamic>).map<ProductInBasket>(
          (x) => ProductInBasket.fromMap(x as Map<String, dynamic>),
        ),
      ),
      orderPrice: map['orderPrice'] as int,
    );
  }

  @override
  String toString() {
    return 'Order(orderID: $orderID, gamerID: $gamerID, gamerName: $gamerName, gamerSurname: $gamerSurname, gamerPhoneNumber: $gamerPhoneNumber, gamerAdress: $gamerAdress, productList: $productList, orderPrice: $orderPrice)';
  }
}
