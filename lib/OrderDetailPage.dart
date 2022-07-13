// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:consolelovers/Model/Gamer.dart';
import 'package:consolelovers/Model/Product.dart';

class OrderDetailPage extends StatelessWidget {
  final List<Product> productList;
  final Gamer gamer;
  final int orderPrice;

  OrderDetailPage({
    Key? key,
    required this.productList,
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
                        decoration: const InputDecoration(
                            label: Text('Name'), border: OutlineInputBorder()),
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
                        decoration: const InputDecoration(
                            label: Text('Surname'),
                            border: OutlineInputBorder()),
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
                decoration: const InputDecoration(
                    label: Text('Phone Number'), border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                minLines: 3,
                maxLines: 3,
                controller: controllerGamerAdress,
                decoration: const InputDecoration(
                    label: Text('Adress'), border: OutlineInputBorder()),
              ),
            ),
            Container(
              height: 350,
              child: ListView.builder(
                itemCount: productList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Theme.of(context).primaryColor,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
