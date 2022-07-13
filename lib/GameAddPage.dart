// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:consolelovers/CommonFunction.dart';
import 'package:consolelovers/CommonWidget/TextFormFiled_AddPage.dart';
import 'package:consolelovers/Model/Console.dart';
import 'package:consolelovers/Model/Game.dart';
import 'package:consolelovers/Services/FirebaseDbService.dart';
import 'package:consolelovers/Services/FirebaseStorageService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GameAddPage extends StatefulWidget {
  const GameAddPage({Key? key}) : super(key: key);

  @override
  State<GameAddPage> createState() => _GameAddPageState();
}

class _GameAddPageState extends State<GameAddPage> {
  final FirebaseDbService _firebaseDbService = FirebaseDbService();
  final FirebaseStorageService _firebaseStorageService =
      FirebaseStorageService();

  late TextEditingController _controllerName;
  late TextEditingController _controllerSummary;
  late TextEditingController _controllerStock;
  late TextEditingController _controllerPrice;
  late ImagePicker _imagePicker;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    getAllConsole();
    _imagePicker = ImagePicker();
    _controllerName = TextEditingController();
    _controllerSummary = TextEditingController();
    _controllerStock = TextEditingController();
    _controllerPrice = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerSummary.dispose();
    _controllerStock.dispose();
    _controllerPrice.dispose();
    super.dispose();
  }

  String gameGenre = '';
  String gameConsole = '';
  String gamePhotoUrl = '';
  List<Console> _consoleList = [];
  var gamePhoto;
  late String gameID = CommonFunction.generateRandomString(6);

  Future<String?> _uploadProfilphoto(BuildContext context) async {
    String? url;
    if (gamePhoto != null) {
      url = await _firebaseStorageService.uploadFile(
          gameID, "console_photo", gamePhoto);
      debugPrint("Gelen url: $gamePhotoUrl");
    }
    return url ??
        'https://media.wired.com/photos/61bd260a09d5d159e1c3bd68/master/pass/Gear-Nintendo-Switch-OLED.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: SingleChildScrollView(
            child: Wrap(
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.orange,
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: 175,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: const Icon(
                                    Icons.camera,
                                    color: Colors.black,
                                  ),
                                  title: const Text('Kameradan Çek.'),
                                  onTap: () {
                                    _kameradanCek();
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(
                                      Icons.photo_size_select_actual_sharp,
                                      color: Colors.black),
                                  title: const Text('Galeriden Seç.'),
                                  onTap: () {
                                    _galeridenSec();
                                  },
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: CircleAvatar(
                    radius: 75,
                    backgroundImage: (gamePhoto != null
                            ? FileImage(gamePhoto)
                            : const NetworkImage(
                                'https://productimages.hepsiburada.net/s/29/550/10268505636914.jpg'))
                        as ImageProvider,
                  ),
                ),
                textFormFieldConsoleAdd(
                  controller: _controllerName,
                  icon: Icons.gamepad_outlined,
                  hintText: 'Game Name',
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter the game name.';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField(
                    hint: const Text(
                      'Platform',
                      style: TextStyle(color: Colors.white),
                    ),
                    validator: (String? value) {
                      if (value == null) {
                        return 'Please choose the platform. ';
                      }
                      return null;
                    },
                    dropdownColor: Colors.grey.shade900,
                    style: const TextStyle(color: Colors.white),
                    items: _consoleList != null ? dropdownItems1 : null,
                    onChanged: (String? value) {
                      gameConsole = value!;
                    }),
                DropdownButtonFormField(
                    validator: (String? value) {
                      if (value == null) {
                        return 'Please choose the game genre. ';
                      }
                      return null;
                    },
                    hint: const Text(
                      'Game Genre',
                      style: TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.grey.shade900,
                    style: const TextStyle(color: Colors.white),
                    items: dropdownItems2,
                    onChanged: (String? value) {
                      gameGenre = value!;
                    }),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: _controllerSummary,
                  maxLines: null,
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.book,
                        color: Colors.white,
                      ),
                      hintText: 'Game Summary',
                      hintStyle: TextStyle(color: Colors.white)),
                  onSaved: (String? value) {},
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter the game summary.';
                    }
                    return null;
                  },
                ),
                textFormFieldConsoleAdd(
                  controller: _controllerStock,
                  icon: Icons.check_box_outline_blank_sharp,
                  hintText: 'Game Stock',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter the game stock.';
                    }
                    return null;
                  },
                ),
                textFormFieldConsoleAdd(
                  controller: _controllerPrice,
                  icon: Icons.monetization_on_outlined,
                  hintText: 'Game Price',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter the game price.';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        gamePhotoUrl = (await _uploadProfilphoto(context))!;

                        bool isSucced = await _firebaseDbService.createGame(
                          Game(
                            productID: gameID,
                            productType: 'Game',
                            productName: _controllerName.text,
                            consoleID: gameConsole,
                            gameGenre: gameGenre,
                            gameSummary: _controllerSummary.text,
                            productPhotoUrl: gamePhotoUrl,
                            productPrice: int.parse(_controllerPrice.text),
                            productStock: int.parse(_controllerStock.text),
                          ),
                        );
                        if (isSucced) {
                          setState(() {});
                          gameID = CommonFunction.generateRandomString(6);
                          _controllerName.text = '';
                          _controllerStock.text = '';
                          _controllerSummary.text = '';
                          _controllerPrice.text = '';
                          gamePhoto = null;

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Registration successful ...'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'An error occurred during the registration process. ...'),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text('Lets Add Game'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Console>> getAllConsole() async {
    _consoleList = await _firebaseDbService.readConsoles();
    setState(() {});
    return _consoleList;
  }

  void _kameradanCek() async {
    var yeniResim = await _imagePicker.pickImage(source: ImageSource.camera);
    Navigator.of(context).pop();
    setState(() {
      gamePhoto = (File(yeniResim!.path));
    });
  }

  void _galeridenSec() async {
    var yeniResim = await _imagePicker.pickImage(source: ImageSource.gallery);
    Navigator.of(context).pop();
    setState(() {
      gamePhoto = (File(yeniResim!.path));
    });
  }

  List<DropdownMenuItem<String>> get dropdownItems1 {
    List<DropdownMenuItem<String>> menuItems1 = [];
    for (var singleConsole in _consoleList) {
      var SingleItem = DropdownMenuItem(
          value: singleConsole.productID,
          child: Text(singleConsole.productName));
      menuItems1.add(SingleItem);
    }
    return menuItems1;
  }

  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems2 = [
      const DropdownMenuItem(value: "Action ", child: Text("Action")),
      const DropdownMenuItem(value: "Platform ", child: Text("Platform")),
      const DropdownMenuItem(value: "Shooter", child: Text("Shooter")),
      const DropdownMenuItem(value: "Fighting ", child: Text("Fighting ")),
      const DropdownMenuItem(value: "Beat 'em up", child: Text("Beat 'em up")),
      const DropdownMenuItem(value: "Stealth", child: Text("Stealth")),
      const DropdownMenuItem(value: "Survival", child: Text("Survival")),
      const DropdownMenuItem(value: "Rhythm ", child: Text("Rhythm")),
      const DropdownMenuItem(value: "Open-World", child: Text("Open-World")),
      const DropdownMenuItem(value: "Racing", child: Text("Racing")),
      const DropdownMenuItem(value: "Sport", child: Text("Sport")),
      const DropdownMenuItem(
          value: "Battle Royale", child: Text("Battle Royale")),
      const DropdownMenuItem(
          value: "Survival horror", child: Text("Survival horror")),
      const DropdownMenuItem(
          value: "Metroidvania ", child: Text("Metroidvania")),
      const DropdownMenuItem(
          value: "Role-playing ", child: Text("Role-playing")),
      const DropdownMenuItem(value: "Simulation ", child: Text("Simulation")),
    ];
    return menuItems2;
  }
}
