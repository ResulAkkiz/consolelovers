import 'package:consolelovers/CommonWidget/Wrap_ViewPage.dart';
import 'package:consolelovers/Model/Gamer.dart';
import 'package:consolelovers/Model/Product.dart';
import 'package:consolelovers/OrderDetailPage.dart';
import 'package:consolelovers/Services/FirebaseDbService.dart';
import 'package:flutter/material.dart';

class BasketPage extends StatefulWidget {
  final List<Product> listofProduct;
  final Gamer gamer;
  const BasketPage({Key? key, required this.listofProduct, required this.gamer})
      : super(key: key);
  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  Map<String, int> priceofSingleProduct = {};
  int totalPrice = 0;
  late List<int> indexList =
      List<int>.generate(widget.listofProduct.length, (counter) => 1);
  late List<int> hourList =
      List<int>.generate(widget.listofProduct.length, (counter) => 1);

  @override
  void initState() {
    fillPriceList();
    calculateTotalPrice();
    super.initState();
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
                  // onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>OrderDetailPage(productList: widget.listofProduct, gamer: gamer, orderPrice: orderPrice)))},
                  icon: const Icon(Icons.check),
                  label: const Text('Confirm the Order'), onPressed: () {},
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
      priceofSingleProduct
          .addEntries({element.productID: (element.productPrice * 1)}.entries);
    }
  }
}
