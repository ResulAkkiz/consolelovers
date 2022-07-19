import 'package:consolelovers/Model/Order.dart';
import 'package:consolelovers/Model/ProductInBasket.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderSuccessfulPage extends StatelessWidget {
  final Order order;

  const OrderSuccessfulPage({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text(
                'Successful',
                style: GoogleFonts.lato(
                  fontSize: 50,
                  color: Colors.green,
                ),
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    'Order Key: ',
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    order.orderID,
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Icon(
                size: MediaQuery.of(context).size.height / 6,
                Icons.check_circle_outlined,
                color: Colors.green,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Wrap(
                  runSpacing: 10,
                  alignment: WrapAlignment.start,
                  children: [
                    Text(
                        'Name-Surname :${order.gamerName} ${order.gamerSurname}'),
                    Text('Phone Number :${order.gamerPhoneNumber}'),
                    Text('Adress :${order.gamerAdress}'),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                padding: const EdgeInsets.all(18),
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: order.productList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1),
                  itemBuilder: (BuildContext context, int index) {
                    ProductInBasket currentProduct =
                        order.productList[index] as ProductInBasket;
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                      margin: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              currentProduct.productName,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                  shadows: [
                                    const Shadow(
                                      color: Colors.red,
                                      blurRadius: 15,
                                    )
                                  ],
                                  fontSize:
                                      currentProduct.productName.length < 16
                                          ? 25
                                          : 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(15),
                            height: 100,
                            width: 100,
                            child: Image.network(
                              currentProduct.productPhotoUrl,
                              fit: BoxFit.fill,
                            ),
                          ),
                          if (currentProduct.productType == 'Console')
                            Wrap(
                              alignment: WrapAlignment.center,
                              direction: Axis.horizontal,
                              runSpacing: 15,
                              spacing: 15,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                    color: Colors.red,
                                  ),
                                  child: Text(
                                    'Amount :${currentProduct.productBuyAmount}',
                                    style:
                                        GoogleFonts.lato(color: Colors.white),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                    color: Colors.red,
                                  ),
                                  child: Text(
                                    'Hour :${currentProduct.productBuyHour}',
                                    style:
                                        GoogleFonts.lato(color: Colors.white),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                    color: Colors.red,
                                  ),
                                  child: Text(
                                    'Amount :${currentProduct.productBuyAmount}',
                                    style:
                                        GoogleFonts.lato(color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {}, child: const Text('Go to Homepage')),
                  ElevatedButton(
                      onPressed: () {}, child: const Text('Go to My Order'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
