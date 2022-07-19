import 'dart:math';

import 'package:consolelovers/BasketPage.dart';
import 'package:consolelovers/ConsoleViewPage.dart';
import 'package:consolelovers/GameViewPage.dart';
import 'package:consolelovers/Model/Gamer.dart';
import 'package:consolelovers/Model/Product.dart';
import 'package:consolelovers/Model/ProductInBasket.dart';
import 'package:consolelovers/ProfilePage.dart';
import 'package:consolelovers/Services/FirebaseDbService.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  Gamer gamer;
  HomePage({Key? key, required this.gamer}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseDbService _firebaseDbService = FirebaseDbService();

  List<ProductInBasket> listofProduct = [];
  int currentIndex = 0;
  @override
  void initState() {
    getUserBasket(widget.gamer);
    super.initState();
  }

  late final screens = [
    ConsoleViewPage(
      gamer: widget.gamer,
      voidCallback: () {
        getUserBasket(widget.gamer);
      },
    ),
    GameViewPage(
      gamer: widget.gamer,
      voidCallback: () {
        getUserBasket(widget.gamer);
      },
    ),
    ProfilePage(
      gamer: widget.gamer,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          child: Image.network(widget.gamer.gamerProfilePhoto ??
              'https://cdn4.iconfinder.com/data/icons/evil-icons-user-interface/64/avatar-512.png'),
        ),
        title: Text(
          widget.gamer.gamerID,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await getUserBasket(widget.gamer);
              // ignore: use_build_context_synchronously
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BasketPage(
                    gamer: widget.gamer,
                    listofProduct: listofProduct,
                  ),
                ),
              );
            },
            icon: Stack(
              children: [
                const Icon(Icons.shopping_basket),
                Positioned(
                    top: 0,
                    right: 0,
                    height: 10,
                    width: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Text(
                        listofProduct.length.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .overline!
                            .copyWith(color: Colors.white),
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(label: 'Consoles', icon: Icon(Icons.games)),
          BottomNavigationBarItem(label: 'Games', icon: Icon(Icons.rowing)),
          BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person)),
        ],
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }

  Future<void> getUserBasket(Gamer gamer) async {
    listofProduct = await _firebaseDbService.readUserBasket(gamer.gamerID);
    setState(() {});
  }
}
