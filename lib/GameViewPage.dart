import 'package:consolelovers/Model/Game.dart';
import 'package:consolelovers/Model/Gamer.dart';
import 'package:consolelovers/Services/FirebaseDbService.dart';
import 'package:flutter/material.dart';

import 'CommonWidget/Wrap_ViewPage.dart';

class GameViewPage extends StatefulWidget {
  Gamer gamer;
  final VoidCallback voidCallback;
  GameViewPage({Key? key, required this.voidCallback, required this.gamer})
      : super(key: key);

  @override
  State<GameViewPage> createState() => _GameViewPageState();
}

class _GameViewPageState extends State<GameViewPage> {
  @override
  Widget build(BuildContext context) {
    FirebaseDbService _firebaseDbService = FirebaseDbService();
    return Scaffold(
      body: FutureBuilder(
          future: _firebaseDbService.readGames(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<Game> listofGame = snapshot.data;
              if (listofGame.isNotEmpty) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 2)),
                  itemCount: listofGame.length,
                  itemBuilder: (BuildContext context, int index) {
                    Game currentGame = listofGame[index];
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                      margin: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              currentGame.productName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                              height: 150,
                              width: 200,
                              child: Image.network(
                                currentGame.productPhotoUrl,
                                fit: BoxFit.fill,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildWrap(currentGame.productStock.toString(),
                                  iconData: Icons.bolt, labelText: 'Stock'),
                              buildWrap(currentGame.productPrice.toString(),
                                  iconData: Icons.monetization_on,
                                  labelText: 'Price'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildWrap(currentGame.consoleID,
                                  iconData: Icons.videogame_asset,
                                  labelText: 'Platform'),
                              Chip(
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  label: Text(
                                    'Genre: ${currentGame.gameGenre} ',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.red),
                                  ))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.add_shopping_cart),
                              label: const Text('Add to Cart'),
                              onPressed: () {
                                widget.voidCallback();
                                currentGame;
                                _firebaseDbService.savetoBasket(
                                    widget.gamer.gamerID, currentGame);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return noGamePage(context);
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

  Center noGamePage(BuildContext context) {
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
            'There is no game in the application.',
            style:
                TextStyle(color: Theme.of(context).primaryColor, fontSize: 15),
          )
        ],
      ),
    );
  }
}
