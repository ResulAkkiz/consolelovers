// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:consolelovers/Model/Product.dart';

class ProductInBasket extends Product {
  int productBuyAmount;
  int? productBuyHour;

  ProductInBasket(
      {required this.productBuyAmount,
      this.productBuyHour,
      required super.productID,
      required super.productName,
      required super.productPhotoUrl,
      required super.productType,
      required super.productStock,
      required super.productPrice});

  @override
  Map<String, dynamic> toMap() {
    return {
      'productID': productID,
      'productName': productName,
      'productType': productType,
      'productBuyHour': productBuyHour,
      'productBuyAmount': productBuyAmount,
      'productPhotoUrl': productPhotoUrl,
      'productStock': productStock,
      'productPrice': productPrice,
    };
  }

  factory ProductInBasket.fromMap(Map<String, dynamic> map) {
    return ProductInBasket(
      productID: map['productID'],
      productName: map['productName'],
      productBuyAmount: map['productBuyAmount'],
      productBuyHour: map['productBuyHour'],
      productStock: map['productStock'],
      productType: map['productType'],
      productPhotoUrl: map['productPhotoUrl'],
      productPrice: map['productPrice'],
    );
  }

  @override
  String toString() =>
      'ProductInBasket(productBuyAmount: $productBuyAmount, productBuyHour: $productBuyHour)';
}
