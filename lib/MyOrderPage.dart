import 'package:consolelovers/HomePage.dart';
import 'package:consolelovers/Model/Gamer.dart';
import 'package:consolelovers/Model/Order.dart';
import 'package:consolelovers/Model/Product.dart';
import 'package:consolelovers/Services/FirebaseAuthService.dart';
import 'package:consolelovers/Services/FirebaseDbService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrdersPage extends StatelessWidget {
  final FirebaseDbService _firebaseDbService = FirebaseDbService();
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  MyOrdersPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'My Orders',
          style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        actions: [
          IconButton(
              onPressed: () {
                getGamer().then((value) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        gamer: value,
                      ),
                    ),
                  );
                });
              },
              icon: const Icon(
                Icons.home_rounded,
                size: 35,
              ))
        ],
        centerTitle: true,
      ),
      body: FutureBuilder(
        future:
            _firebaseDbService.getUserOrders('HuHQnlTQHFYQug3t9FWCUIH6dkm1'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Order> listofOrder = snapshot.data;
            return ListView.builder(
              itemCount: listofOrder.length,
              itemBuilder: (BuildContext context, int index) {
                Order currentOrder = listofOrder[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 6,
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(10))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Order ID: ',
                              style: GoogleFonts.lato(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              currentOrder.orderID,
                              style: GoogleFonts.lato(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 60,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: currentOrder.productList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Product currentProduct =
                                      currentOrder.productList[index];
                                  return SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Image.network(
                                        currentProduct.productPhotoUrl),
                                  );
                                },
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                text: 'Total Price:',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ), // default text style
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '${currentOrder.orderPrice} \$',
                                    style: GoogleFonts.lato(
                                        fontSize: 17,
                                        color: Theme.of(context)
                                            .appBarTheme
                                            .backgroundColor),
                                  ),
                                ],
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<Gamer> getGamer() async {
    Gamer gamer = (await _firebaseAuthService.currentUser())!;
    return await _firebaseDbService.readGamer(gamer.gamerID);
  }
}
