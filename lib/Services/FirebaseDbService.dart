import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consolelovers/Model/Console.dart';
import 'package:consolelovers/Model/Game.dart';
import 'package:consolelovers/Model/Gamer.dart';
import 'package:consolelovers/Model/Order.dart';
import 'package:consolelovers/Model/Product.dart';
import 'package:consolelovers/Model/ProductInBasket.dart';
import 'package:consolelovers/Services/DbBase.dart';
import 'package:flutter/cupertino.dart';

class FirebaseDbService extends DbBase {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<bool> createConsole(Console console) async {
    _firebaseFirestore
        .collection('console')
        .doc(console.productID)
        .set(console.toMap());

    debugPrint('Kayıt işlemi gerçekleşti');
    return true;
  }

  @override
  Future<List<Console>> readConsoles() async {
    var snapshots = await _firebaseFirestore.collection('console').get();

    List<Console> allConsoles = [];

    for (var singleConsole in snapshots.docs) {
      Console _console = Console.fromMap(singleConsole.data());
      allConsoles.add(_console);
    }

    return allConsoles;
  }

  @override
  Future<bool> createGame(Game game) async {
    _firebaseFirestore.collection('game').doc(game.productID).set(game.toMap());

    debugPrint('Kayıt işlemi gerçekleşti');
    return true;
  }

  @override
  Future<List<Game>> readGames() async {
    QuerySnapshot<Map<String, dynamic>> snapshots =
        await _firebaseFirestore.collection('game').get();
    List<Game> allGames = [];
    for (var singleGame in snapshots.docs) {
      Game _game = Game.fromMap(singleGame.data());
      allGames.add(_game);
    }
    return allGames;
  }

  @override
  Future<bool> savetoBasket(String userID, Product product) async {
    ProductInBasket productInBasket = ProductInBasket(
      productBuyAmount: 1,
      productBuyHour: 1,
      productID: product.productID,
      productName: product.productName,
      productPhotoUrl: product.productPhotoUrl,
      productPrice: product.productPrice,
      productStock: product.productStock,
      productType: product.productType,
    );
    _firebaseFirestore.collection('basket').doc(userID).set(
        {productInBasket.productID: productInBasket.toMap()},
        SetOptions(merge: true));
    debugPrint(productInBasket.toString());
    return true;
  }

  @override
  Future<bool> deleteBasket(String userID) async {
    await _firebaseFirestore.collection("basket").doc("userID").delete().then(
          (doc) => debugPrint("Document deleted"),
          onError: (e) => debugPrint("Error updating document $e"),
        );
    return true;
  }

  @override
  Future<List<ProductInBasket>> readUserBasket(String userID) async {
    List<ProductInBasket> productList = [];
    DocumentSnapshot<Map<String, dynamic>> snapshotProduct =
        await _firebaseFirestore.collection("basket").doc(userID).get();

    for (Map<String, dynamic> singleProduct in snapshotProduct.data()!.values) {
      ProductInBasket _productInBasket = ProductInBasket.fromMap(singleProduct);
      productList.add(_productInBasket);
    }
    return productList;
  }

  Future<bool> saveGamer(Gamer gamer) async {
    _firebaseFirestore
        .collection('gamer')
        .doc(gamer.gamerID)
        .set(gamer.toMap());
    return true;
  }

  Future<Gamer> readGamer(String gamerID) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firebaseFirestore.collection('gamer').doc(gamerID).get();
    return Gamer.fromMap(snapshot.data()!);
  }

  Future<bool> updateGamer(Gamer gamer) async {
    _firebaseFirestore
        .collection('gamer')
        .doc(gamer.gamerID)
        .update(gamer.toMap());
    return true;
  }

  Future<bool> updateAmount(Gamer gamer, Product product, int value) async {
    await _firebaseFirestore.collection('basket').doc(gamer.gamerID).set({
      product.productID: {'productBuyAmount': value}
    }, SetOptions(merge: true));
    return true;
  }

  Future<bool> updateHour(Gamer gamer, Product product, int value) async {
    await _firebaseFirestore.collection('basket').doc(gamer.gamerID).set({
      product.productID: {'productBuyHour': value}
    }, SetOptions(merge: true));
    return true;
  }

  @override
  Future<bool> saveOrder(Order order) async {
    await _firebaseFirestore
        .collection('order')
        .doc(order.gamerID)
        .set({order.orderID: order.toMap()}, SetOptions(merge: true));
    return true;
  }

  @override
  Future<Console> getConsolebyID(String consoleID) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firebaseFirestore.collection('console').doc(consoleID).get();
    return Console.fromMap(snapshot.data()!);
  }

  Future<void> deleteProduct(String userID, String productID) async {
    var docRef = _firebaseFirestore.collection('basket').doc(userID);
    final updates = <String, dynamic>{
      productID: FieldValue.delete(),
    };
    docRef.update(updates);
  }

  Future<List<Order>> getUserOrders(String userID) async {
    Map<String, dynamic>? map =
        (await _firebaseFirestore.collection('order').doc(userID).get()).data();
    List<Order> listofOrder = [];
    if (map != null) {
      map.forEach((key, value) {
        listofOrder.add(Order.fromMap(value));
      });
    }
    return listofOrder;
  }
}
