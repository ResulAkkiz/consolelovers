// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:consolelovers/CommonFunction.dart';
import 'package:consolelovers/Model/Order.dart';
import 'package:consolelovers/Model/ProductInBasket.dart';
import 'package:consolelovers/OrderSuccessfulPage.dart';
import 'package:consolelovers/Services/FirebaseDbService.dart';
import 'package:flutter/material.dart';

import 'package:consolelovers/Model/Gamer.dart';

import 'package:google_fonts/google_fonts.dart';

class OrderDetailPage extends StatelessWidget {
  final FirebaseDbService _firebaseDbService = FirebaseDbService();
  List<ProductInBasket> productList = [];
  final Gamer gamer;
  final int orderPrice;

  OrderDetailPage({
    Key? key,
    required this.gamer,
    required this.orderPrice,
  }) : super(key: key);
  TextEditingController controllerGamerPhonenumber = TextEditingController();
  TextEditingController controllerGamerAdress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controllerGamerPhonenumber.text = gamer.gamerPhoneNumber ?? '';
    controllerGamerAdress.text = gamer.gamerAdress ?? '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: gamer.gamerName,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .appBarTheme
                                  .backgroundColor!,
                              width: 3.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .appBarTheme
                                  .backgroundColor!,
                              width: 2.0,
                            ),
                          ),
                          labelStyle: GoogleFonts.lato(
                              fontSize: 20,
                              color: Theme.of(context)
                                  .appBarTheme
                                  .backgroundColor),
                          label: Text('Name'),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: gamer.gamerSurname,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .appBarTheme
                                  .backgroundColor!,
                              width: 3.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .appBarTheme
                                  .backgroundColor!,
                              width: 2.0,
                            ),
                          ),
                          labelStyle: GoogleFonts.lato(
                              fontSize: 20,
                              color: Theme.of(context)
                                  .appBarTheme
                                  .backgroundColor),
                          label: Text('Surname'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controllerGamerPhonenumber,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).appBarTheme.backgroundColor!,
                      width: 3.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).appBarTheme.backgroundColor!,
                      width: 2.0,
                    ),
                  ),
                  labelStyle: GoogleFonts.lato(
                      fontSize: 20,
                      color: Theme.of(context).appBarTheme.backgroundColor),
                  label: Text('Phone Number'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                minLines: 3,
                maxLines: 3,
                controller: controllerGamerAdress,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).appBarTheme.backgroundColor!,
                      width: 3.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).appBarTheme.backgroundColor!,
                      width: 2.0,
                    ),
                  ),
                  labelStyle: GoogleFonts.lato(
                      fontSize: 20,
                      color: Theme.of(context).appBarTheme.backgroundColor),
                  label: const Text('Adress'),
                ),
              ),
            ),
            Container(
              height: 390,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: FutureBuilder(
                future: _firebaseDbService.readUserBasket(gamer.gamerID),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    productList = snapshot.data;
                    return ListView.builder(
                      itemCount: productList.length,
                      itemBuilder: (BuildContext context, int index) {
                        ProductInBasket currentProduct = productList[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 10,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurStyle: BlurStyle.solid,
                                    color: Theme.of(context)
                                        .appBarTheme
                                        .backgroundColor!,
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: const Offset(-2, 4)),
                              ],
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      currentProduct.productPhotoUrl),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Text(
                                    currentProduct.productName,
                                    style: GoogleFonts.cabin(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                  ),
                                ),
                                if (currentProduct.productType == 'Console')
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    direction: Axis.vertical,
                                    spacing: 5,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2)),
                                          color: Colors.red,
                                        ),
                                        child: Text(
                                          'Amount :${currentProduct.productBuyAmount}',
                                          style: GoogleFonts.lato(
                                              color: Colors.white),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2)),
                                          color: Colors.red,
                                        ),
                                        child: Text(
                                          'Hour :${currentProduct.productBuyHour}',
                                          style: GoogleFonts.lato(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )
                                else
                                  Wrap(
                                    direction: Axis.vertical,
                                    spacing: 5,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2)),
                                          color: Colors.red,
                                        ),
                                        child: Text(
                                          'Amount :${currentProduct.productBuyAmount}',
                                          style: GoogleFonts.lato(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: const Text('Confirm the Order!'),
                onPressed: () {
                  String orderID = CommonFunction.generateRandomString(8);
                  Order order = Order(
                      orderID: orderID,
                      gamerID: gamer.gamerID,
                      gamerName: gamer.gamerName ?? '',
                      gamerSurname: gamer.gamerSurname ?? '',
                      gamerPhoneNumber: controllerGamerPhonenumber.text,
                      gamerAdress: controllerGamerAdress.text,
                      productList: productList,
                      orderPrice: orderPrice);
                  saveOrder(order);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) =>
                              OrderSuccessfulPage(order: order)),
                      ((route) => false));
                },
              ),
              Chip(
                label: Text(
                  'Total Price : $orderPrice',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                backgroundColor: Colors.black87,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> saveOrder(Order order) async {
    return _firebaseDbService.saveOrder(order);
  }
}
