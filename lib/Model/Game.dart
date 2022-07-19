import 'package:consolelovers/Model/Product.dart';

class Game extends Product {
  String consoleID;
  String gameGenre;
  String gameSummary;

  Game(
      {required this.consoleID,
      required this.gameGenre,
      required this.gameSummary,
      required super.productID,
      required super.productName,
      required super.productPhotoUrl,
      required super.productType,
      required super.productStock,
      required super.productPrice});

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      productID: map['productID'],
      productName: map['productName'],
      productStock: map['productStock'],
      consoleID: map['consoleID'],
      gameGenre: map['gameGenre'],
      gameSummary: map['gameSummary'],
      productType: map['productType'],
      productPhotoUrl: map['productPhotoUrl'],
      productPrice: map['productPrice'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'productID': productID,
      'productName': productName,
      'productType': productType,
      'consoleID': consoleID,
      'gameGenre': gameGenre,
      'gameSummary': gameSummary,
      'productPhotoUrl': productPhotoUrl,
      'productStock': productStock,
      'productPrice': productPrice,
    };
  }
}
