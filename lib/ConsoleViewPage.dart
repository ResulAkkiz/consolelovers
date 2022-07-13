import 'package:consolelovers/CommonWidget/Wrap_ViewPage.dart';

import 'package:consolelovers/Model/Console.dart';
import 'package:consolelovers/Model/Gamer.dart';

import 'package:consolelovers/Services/FirebaseDbService.dart';
import 'package:flutter/material.dart';

class ConsoleViewPage extends StatefulWidget {
  Gamer gamer;
  final VoidCallback voidCallback;

  ConsoleViewPage({
    required this.voidCallback,
    required this.gamer,
    Key? key,
  }) : super(key: key);

  @override
  State<ConsoleViewPage> createState() => _ConsoleViewPageState();
}

class _ConsoleViewPageState extends State<ConsoleViewPage> {
  late Console currentConsole;

  @override
  Widget build(BuildContext context) {
    FirebaseDbService _firebaseDbService = FirebaseDbService();
    return Scaffold(
      body: FutureBuilder(
          future: _firebaseDbService.readConsoles(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<Console> listofConsole = snapshot.data;
              if (listofConsole.isNotEmpty) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                  ),
                  itemCount: listofConsole.length,
                  itemBuilder: (BuildContext context, int index) {
                    currentConsole = listofConsole[index];
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                      margin: const EdgeInsets.all(15.0),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: 10,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              currentConsole.productName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                              height: 150,
                              width: 200,
                              child: Image.network(
                                currentConsole.productPhotoUrl,
                                fit: BoxFit.fill,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildWrap(currentConsole.productStock.toString(),
                                  iconData: Icons.bolt, labelText: 'Stock'),
                              buildWrap(currentConsole.productPrice.toString(),
                                  iconData: Icons.monetization_on,
                                  labelText: 'Price'),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.add_shopping_cart),
                              label: const Text('Add to Cart'),
                              onPressed: () {
                                widget.voidCallback();
                                debugPrint(
                                    "Gelen : ${listofConsole[index].toString()}");
                                _firebaseDbService.savetoBasket(
                                    widget.gamer.gamerID, listofConsole[index]);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return noConsolePage(context);
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Center noConsolePage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.highlight_remove,
            size: 110,
            color: Theme.of(context).primaryColor,
          ),
          Text(
            'There is no game console in the application.',
            style:
                TextStyle(color: Theme.of(context).primaryColor, fontSize: 15),
          )
        ],
      ),
    );
  }
}
