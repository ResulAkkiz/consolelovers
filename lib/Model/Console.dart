// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:consolelovers/Model/Product.dart';

class Console extends Product {
  //String consoleID;
  //String name;
  //String consoleImageURL;
  //int amount;
  //int price;
  List<dynamic> types;

  Console(
      {required this.types,
      required super.productPhotoUrl,
      required super.productID,
      required super.productName,
      required super.productType,
      required super.productPrice,
      required super.productStock});

  @override
  Map<String, dynamic> toMap() {
    return {
      'productID': productID,
      'productName': productName,
      'productStock': productStock,
      'productType': productType,
      'productPrice': productPrice,
      'productPhotoUrl': productPhotoUrl,
      'types': types
    };
  }

  factory Console.fromMap(Map<String, dynamic> map) {
    return Console(
        productID: map['productID'],
        productName: map['productName'],
        productStock: map['productStock'],
        productPrice: map['productPrice'],
        productType: map['productType'],
        productPhotoUrl: map['productPhotoUrl'],
        types: map['types']);
  }
}
