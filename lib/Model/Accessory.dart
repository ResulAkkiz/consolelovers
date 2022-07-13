import 'package:consolelovers/Model/Product.dart';

class Accessory extends Product {
  String consoleID;

  Accessory(
      {required this.consoleID,
      required super.productID,
      required super.productName,
      required super.productPhotoUrl,
      required super.productStock,
      required super.productType,
      required super.productPrice});

  @override
  Map<String, dynamic> toMap() {
    return {
      'accessoryID': productID,
      'consoleID': consoleID,
      'name': productName,
      'amount': productStock,
      'price': productPrice,
      'consoleImageURL': productPhotoUrl,
    };
  }

  factory Accessory.fromMap(Map<String, dynamic> map) {
    return Accessory(
      productID: map['accesoryID'],
      productName: map['accesoryName'],
      productStock: map['accesoryStock'],
      consoleID: map['consoleID'],
      productType: map['productType'],
      productPhotoUrl: map['accesoryImageURL'],
      productPrice: map['accesoryPrice'],
    );
  }
}
