import 'package:consolelovers/HomePage.dart';
import 'package:consolelovers/Model/Gamer.dart';
import 'package:consolelovers/Services/FirebaseAuthService.dart';
import 'package:consolelovers/Services/FirebaseDbService.dart';
import 'package:flutter/material.dart';

enum FormType { Register, Login }

class SignInEmailPasswordPage extends StatefulWidget {
  const SignInEmailPasswordPage({Key? key}) : super(key: key);

  @override
  State<SignInEmailPasswordPage> createState() =>
      _SignInEmailPasswordPageState();
}

class _SignInEmailPasswordPageState extends State<SignInEmailPasswordPage> {
  late String email, password;
  late String buttonText, linkText;
  var _formType = FormType.Login;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<Gamer?> _formSubmit() async {
    _formKey.currentState?.save();
    FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
    FirebaseDbService _firebaseDbService = FirebaseDbService();
    if (_formType == FormType.Login) {
      try {
        Gamer? _gamer =
            await _firebaseAuthService.signInEmailPassword(email, password);
        if (_gamer != null) {
          return await _firebaseDbService.readGamer(_gamer.gamerID);
        } else {
          return null;
        }
      } catch (e) {
        debugPrint('Widget SignIn hata meydana geldi:  ${e.toString()}');
      }
    } else {
      try {
        Gamer? _gamer =
            await _firebaseAuthService.createEmailPassword(email, password);
        if (_gamer != null) {
          bool result = await _firebaseDbService.saveGamer(_gamer);
          if (result) {
            return await _firebaseDbService.readGamer(_gamer.gamerID);
          } else {
            return null;
          }
        }
      } catch (e) {
        debugPrint('Widget Create hata meydana geldi:  ${e.toString()}');
      }
    }
  }

  void Change() {
    setState(
      () {
        _formType =
            _formType == FormType.Login ? FormType.Register : FormType.Login;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    buttonText = _formType == FormType.Login ? 'Sign in' : 'Sign up';
    linkText = _formType == FormType.Login
        ? 'Dont have an account? Sign up.'
        : 'Do you have an account? Sign in.';
    FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in/Sign up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  initialValue: 'resul@gmail.com',
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Theme.of(context).primaryColor),
                      ),
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Theme.of(context).primaryColor,
                      ),
                      hintText: 'E-mail',
                      labelStyle: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 20),
                      labelText: 'E-mail',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).primaryColor))),
                  onSaved: (value) {
                    email = value!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  initialValue: '123456',
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Theme.of(context).primaryColor)),
                    prefixIcon: Icon(
                      Icons.password_sharp,
                      color: Theme.of(context).primaryColor,
                    ),
                    labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 20),
                    hintText: 'Password',
                    labelText: 'Password',
                  ),
                  onSaved: (value) {
                    password = value!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    Gamer? _gamer = await _formSubmit();
                    if (_gamer != null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => HomePage(gamer: _gamer)),
                        ),
                      );
                    }
                  },
                  child: Text(buttonText),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    Change();
                  },
                  child: Text(linkText),
                ),
                Expanded(child: Image.asset('assets/Images/MarioMainPage.png'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
