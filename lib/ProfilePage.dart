import 'package:consolelovers/Model/Gamer.dart';
import 'package:consolelovers/Services/FirebaseAuthService.dart';
import 'package:consolelovers/Services/FirebaseDbService.dart';
import 'package:consolelovers/SignInEmailPasswordPage.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key, required this.gamer}) : super(key: key);
  Gamer gamer;
  TextEditingController controllerGamerName = TextEditingController();
  TextEditingController controllerGamerSurname = TextEditingController();
  TextEditingController controllerGamerPhonenumber = TextEditingController();
  TextEditingController controllerGamerAdress = TextEditingController();
  @override
  Widget build(BuildContext context) {
    FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
    FirebaseDbService _firebaseDbService = FirebaseDbService();
    controllerGamerName.text = gamer.gamerName ?? '';
    controllerGamerSurname.text = gamer.gamerSurname ?? '';
    controllerGamerPhonenumber.text = gamer.gamerPhoneNumber ?? '';
    controllerGamerAdress.text = gamer.gamerAdress ?? '';
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 75,
                  backgroundImage: NetworkImage(gamer.gamerProfilePhoto!),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  initialValue: gamer.gamerEmail,
                  readOnly: true,
                  decoration: const InputDecoration(
                      label: Text('Email'), border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: controllerGamerName,
                  decoration: const InputDecoration(
                      label: Text('Name'), border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: controllerGamerSurname,
                  decoration: const InputDecoration(
                      label: Text('Surname'), border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.phone,
                  controller: controllerGamerPhonenumber,
                  decoration: const InputDecoration(
                      label: Text('Phone Number'),
                      border: OutlineInputBorder()),
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
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        gamer.gamerName = controllerGamerName.text;
                        gamer.gamerSurname = controllerGamerSurname.text;
                        gamer.gamerPhoneNumber =
                            controllerGamerPhonenumber.text;
                        gamer.gamerAdress = controllerGamerAdress.text;
                        _firebaseDbService.updateGamer(gamer);
                      },
                      child: const Text('Update Your Account')))
            ],
          ),
        ),
      ),
    );
  }
}
