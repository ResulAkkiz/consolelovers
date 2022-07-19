import 'package:consolelovers/Model/Console.dart';
import 'package:consolelovers/Model/Game.dart';
import 'package:consolelovers/Model/Order.dart';
import 'package:consolelovers/Model/Product.dart';

abstract class DbBase {
  Future<bool> createConsole(Console console);
  Future<List<Console>> readConsoles();
  Future<bool> createGame(Game game);
  Future<List<Game>> readGames();
  Future<bool> savetoBasket(String userID, Product product);
  Future<bool> deleteBasket(String userID);
  Future<List<Product>> readUserBasket(String userID);
  Future<bool> saveOrder(Order order);
}
