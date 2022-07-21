import 'dart:math';

import 'package:consolelovers/BasketPage.dart';
import 'package:consolelovers/ConsoleViewPage.dart';
import 'package:consolelovers/GameViewPage.dart';
import 'package:consolelovers/Model/Gamer.dart';
import 'package:consolelovers/Model/Product.dart';
import 'package:consolelovers/Model/ProductInBasket.dart';
import 'package:consolelovers/ProfilePage.dart';
import 'package:consolelovers/Services/FirebaseAuthService.dart';
import 'package:consolelovers/Services/FirebaseDbService.dart';
import 'package:consolelovers/SignInEmailPasswordPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  Gamer gamer;
  HomePage({Key? key, required this.gamer}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseDbService _firebaseDbService = FirebaseDbService();
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

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
      appBar: currentIndex != 2
          ? AppBar(
              centerTitle: true,
              leading: CircleAvatar(
                child: Image.network(widget.gamer.gamerProfilePhoto ??
                    'https://cdn4.iconfinder.com/data/icons/evil-icons-user-interface/64/avatar-512.png'),
              ),
              title: Text(
                '${widget.gamer.gamerName!} ${widget.gamer.gamerSurname}',
                style:
                    GoogleFonts.lato(fontSize: 25, fontWeight: FontWeight.bold),
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
            )
          : AppBar(
              automaticallyImplyLeading: false,
              title: const Text('My Profile'),
              centerTitle: true,
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      _firebaseAuthService.signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) =>
                                const SignInEmailPasswordPage(),
                          ),
                          ((route) => false));
                    },
                    child: const Text(
                      "Sign Out",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
              label: 'Consoles',
              icon: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset('assets/Icons/IconConsole.png'))),
          BottomNavigationBarItem(
              label: 'Games',
              icon: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset('assets/Icons/IconFlyingMario.png'))),
          BottomNavigationBarItem(
              label: 'Profile',
              icon: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset('assets/Icons/IconMushroom.png'))),
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
