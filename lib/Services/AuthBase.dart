import 'package:consolelovers/Model/Gamer.dart';

abstract class AuthBase {
  Future<Gamer?> currentUser();
  Future<Gamer?> createEmailPassword(String email, String sifre);
  Future<Gamer?> signInEmailPassword(String email, String sifre);
}
