import 'package:consolelovers/CommonWidget/Wrap_ViewPage.dart';
import 'package:consolelovers/Model/Gamer.dart';
import 'package:consolelovers/Model/Product.dart';
import 'package:consolelovers/Model/ProductInBasket.dart';
import 'package:consolelovers/OrderDetailPage.dart';
import 'package:consolelovers/Services/FirebaseDbService.dart';
import 'package:flutter/material.dart';

class BasketPage extends StatefulWidget {
  List<ProductInBasket> listofProduct;
  final Gamer gamer;
  BasketPage({Key? key, required this.listofProduct, required this.gamer})
      : super(key: key);
  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  Map<String, int> priceofSingleProduct = {};
  int totalPrice = 0;

  late List<int> indexList = [];
  late List<int> hourList = [];

  @override
  void initState() {
    indexList = getAmounts();
    hourList = getHours();

    fillPriceList();
    calculateTotalPrice();
    super.initState();
  }

  List<int> getAmounts() {
    List<int> amounts = [];
    for (var element in widget.listofProduct) {
      amounts.add(element.productBuyAmount);
    }
    return amounts;
  }

  List<int> getHours() {
    List<int> hours = [];
    for (var element in widget.listofProduct) {
      hours.add(element.productBuyHour ?? 1);
    }
    return hours;
  }

  final FirebaseDbService _firebaseDbService = FirebaseDbService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Basket'),
        actions: [
          IconButton(
              onPressed: () async {
                await _firebaseDbService.deleteBasket("R4sul");
                setState(() {});
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: widget.listofProduct.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1),
              itemBuilder: (context, index) {
                Product currentProduct = widget.listofProduct[index];
                return singleBasketView(currentProduct, index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  label: const Text('Confirm the Order'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OrderDetailPage(
                            gamer: widget.gamer, orderPrice: totalPrice),
                      ),
                    );
                  },
                ),
                Chip(
                  label: Text('Total Price :$totalPrice'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container singleBasketView(Product currentProduct, int index) {
    if (currentProduct.productType == 'Console') {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        margin: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                currentProduct.productName,
                textAlign: TextAlign.center,
                maxLines: 3,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
                height: 150,
                width: 200,
                child: Image.network(
                  currentProduct.productPhotoUrl,
                  fit: BoxFit.fill,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildWrap(currentProduct.productPrice.toString(),
                    iconData: Icons.monetization_on,
                    labelText: 'Price per Hour'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Amount:'),
                    DropdownButton(
                      items: buildMenu(5),
                      value: indexList[index],
                      onChanged: (int? value) {
                        setState(
                          () {
                            updateAmount(currentProduct, value);
                            indexList[index] = value!;
                            priceofSingleProduct.addEntries({
                              currentProduct.productID: calculateSinglePrice(
                                  currentProduct.productPrice,
                                  indexList[index],
                                  null,
                                  currentProduct.productType)
                            }.entries);
                            calculateTotalPrice();
                          },
                        );
                      },
                    ),
                    const Text('Hour:'),
                    DropdownButton(
                      items: buildMenu(5),
                      value: hourList[index],
                      onChanged: (int? value) {
                        setState(
                          () {
                            updateHour(currentProduct, value);
                            hourList[index] = value!;
                            priceofSingleProduct.addEntries({
                              currentProduct.productID: calculateSinglePrice(
                                  currentProduct.productPrice,
                                  indexList[index],
                                  hourList[index],
                                  currentProduct.productType)
                            }.entries);
                            calculateTotalPrice();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        margin: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                currentProduct.productName,
                textAlign: TextAlign.center,
                maxLines: 3,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
                height: 150,
                width: 200,
                child: Image.network(
                  currentProduct.productPhotoUrl,
                  fit: BoxFit.fill,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildWrap(currentProduct.productPrice.toString(),
                    iconData: Icons.monetization_on, labelText: 'Price'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Amount:'),
                    DropdownButton(
                      items: buildMenu(5),
                      value: indexList[index],
                      onChanged: (int? value) {
                        setState(
                          () {
                            updateAmount(currentProduct, value);
                            indexList[index] = value!;
                            priceofSingleProduct.addEntries({
                              currentProduct.productID: calculateSinglePrice(
                                  currentProduct.productPrice,
                                  indexList[index],
                                  null,
                                  currentProduct.productType)
                            }.entries);
                            calculateTotalPrice();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  Future<bool> updateHour(Product currentProduct, int? value) async {
    return await _firebaseDbService.updateHour(
        widget.gamer, currentProduct, value!);
  }

  Future<bool> updateAmount(Product currentProduct, int? value) async {
    return await _firebaseDbService.updateAmount(
        widget.gamer, currentProduct, value!);
  }

  List<DropdownMenuItem<int>> buildMenu(int maxValue) {
    List<DropdownMenuItem<int>> listMenuItem = [];
    for (var i = 1; i <= maxValue; i++) {
      listMenuItem.add(
        DropdownMenuItem(
          value: i,
          child: Text(
            i.toString(),
          ),
        ),
      );
    }
    return listMenuItem;
  }

  void calculateTotalPrice() {
    totalPrice = 0;
    for (var element in priceofSingleProduct.values) {
      totalPrice = totalPrice + element;
    }
  }

  int calculateSinglePrice(
    int price,
    int amount,
    int? hour,
    String productType,
  ) {
    int result;

    hour = hour ?? 1;
    if (productType == 'Console') {
      result = price * amount * hour;
    } else {
      result = price * amount;
    }
    return result;
  }

  void fillPriceList() {
    for (var element in widget.listofProduct) {
      element.productBuyHour = element.productBuyHour ?? 1;
      priceofSingleProduct.addEntries({
        element.productID: (element.productPrice *
            element.productBuyHour! *
            element.productBuyAmount)
      }.entries);
    }
  }
}
