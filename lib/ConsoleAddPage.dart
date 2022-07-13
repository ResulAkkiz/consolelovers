// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:math';

import 'package:consolelovers/CommonFunction.dart';
import 'package:consolelovers/CommonWidget/TextFormFiled_AddPage.dart';
import 'package:consolelovers/Model/Console.dart';
import 'package:consolelovers/Services/FirebaseDbService.dart';
import 'package:consolelovers/Services/FirebaseStorageService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ConsoleAddPage extends StatefulWidget {
  const ConsoleAddPage({Key? key}) : super(key: key);

  @override
  State<ConsoleAddPage> createState() => _ConsoleAddPageState();
}

class _ConsoleAddPageState extends State<ConsoleAddPage> {
  final FirebaseDbService _firebaseDbService = FirebaseDbService();
  final FirebaseStorageService _firebaseStorageService =
      FirebaseStorageService();

  late TextEditingController _controllerName;
  late TextEditingController _controllerAmount;
  late TextEditingController _controllerPrice;
  late ImagePicker _imagePicker;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _imagePicker = ImagePicker();
    _controllerName = TextEditingController();
    _controllerAmount = TextEditingController();
    _controllerPrice = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerAmount.dispose();
    _controllerPrice.dispose();
    super.dispose();
  }

  String consoleType1 = '';
  String consoleType2 = '';
  var consolePhoto;
  late String consoleID = CommonFunction.generateRandomString(6);
  String consolePhotoUrl = '';
  List<String?> consoleTypes = [];

  Future<String?> _uploadProfilphoto(BuildContext context) async {
    String? url;
    if (consolePhoto != null) {
      url = await _firebaseStorageService.uploadFile(
          consoleID, "console_photo", consolePhoto);
      debugPrint("Gelen url: $consolePhotoUrl");
    }
    return url ??
        'https://media.wired.com/photos/61bd260a09d5d159e1c3bd68/master/pass/Gear-Nintendo-Switch-OLED.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Game Console'),
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
                    backgroundImage: (consolePhoto != null
                            ? FileImage(consolePhoto)
                            : const NetworkImage(
                                'https://media.wired.com/photos/61bd260a09d5d159e1c3bd68/master/pass/Gear-Nintendo-Switch-OLED.jpg'))
                        as ImageProvider,
                  ),
                ),
                textFormFieldConsoleAdd(
                  controller: _controllerName,
                  icon: Icons.gamepad_outlined,
                  hintText: 'Console Name',
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter the console name.';
                    }
                    return null;
                  },
                ),
                textFormFieldConsoleAdd(
                  controller: _controllerAmount,
                  icon: Icons.check_box_outline_blank_sharp,
                  keyboardType: TextInputType.number,
                  hintText: 'Console Amount',
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter the console amount.';
                    }
                    return null;
                  },
                ),
                textFormFieldConsoleAdd(
                  controller: _controllerPrice,
                  icon: Icons.monetization_on_outlined,
                  hintText: 'Console Price/Per hour',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter the console price.';
                    }
                    return null;
                  },
                ),
                buildDropdownButtonType(dropdownItems1, true),
                buildDropdownButtonType(dropdownItems2, false),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        consolePhotoUrl = (await _uploadProfilphoto(context))!;
                        consoleTypes = [consoleType1, consoleType2];
                        bool isSucced = await _firebaseDbService.createConsole(
                          Console(
                              productID: consoleID,
                              productType: 'Console',
                              productName: _controllerName.text,
                              productStock: int.parse(_controllerAmount.text),
                              productPrice: int.parse(_controllerPrice.text),
                              productPhotoUrl: consolePhotoUrl,
                              types: consoleTypes),
                        );
                        if (isSucced) {
                          setState(() {});
                          consoleID = CommonFunction.generateRandomString(6);
                          _controllerName.text = '';
                          _controllerAmount.text = '';
                          _controllerPrice.text = '';
                          consolePhoto = null;

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
                    child: const Text('Lets Add Console'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownButtonFormField<String> buildDropdownButtonType(
      List<DropdownMenuItem<String>>? items, bool type) {
    return DropdownButtonFormField(
        validator: (String? value) {
          if (value == null) {
            return 'Please choose type of console ';
          }
          return null;
        },
        dropdownColor: Colors.grey.shade900,
        style: const TextStyle(color: Colors.white),
        items: items,
        onChanged: (String? value) {
          type ? consoleType1 = value! : consoleType2 = value!;
        });
  }

  void _kameradanCek() async {
    var yeniResim = await _imagePicker.pickImage(source: ImageSource.camera);
    Navigator.of(context).pop();
    setState(() {
      consolePhoto = (File(yeniResim!.path));
    });
  }

  void _galeridenSec() async {
    var yeniResim = await _imagePicker.pickImage(source: ImageSource.gallery);
    Navigator.of(context).pop();
    setState(() {
      consolePhoto = (File(yeniResim!.path));
    });
  }

  List<DropdownMenuItem<String>> get dropdownItems1 {
    List<DropdownMenuItem<String>> menuItems1 = [
      const DropdownMenuItem(value: "Hybrid", child: Text("Hybrid")),
      const DropdownMenuItem(value: "Handheld", child: Text("Handheld")),
      const DropdownMenuItem(value: "Home", child: Text("Home")),
    ];
    return menuItems1;
  }

  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems2 = [
      const DropdownMenuItem(value: "Retro", child: Text("Retro")),
      const DropdownMenuItem(value: "On Market", child: Text("On Market")),
      const DropdownMenuItem(
          value: "Old Generation", child: Text("Old Generation")),
    ];
    return menuItems2;
  }
}
