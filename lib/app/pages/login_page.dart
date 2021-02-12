import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';
import 'package:woas/app/services/firebase_service.dart';

import '../../service_locator.dart';
import 'dashboard_page.dart';

class LoginPage extends StatefulWidget {
  static final String route = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _firebaseService = locator<FirebaseService>();
  bool isSpinning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Meine Aktivitäten'),
          centerTitle: true,
        ),
        body: SafeArea(
            child: ModalProgressHUD(
                inAsyncCall: isSpinning,
                child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children:
                      [
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Emailadresse',
                            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(32.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(32.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
                              borderRadius: BorderRadius.all(Radius.circular(32.0)),
                            ),
                          )
                        ),
                        SizedBox(height: 10.0),
                        TextField(
                          controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'Passwort',
                              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(32.0)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                borderRadius: BorderRadius.all(Radius.circular(32.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
                                borderRadius: BorderRadius.all(Radius.circular(32.0)),
                              ),
                            )

                        ),
                        SizedBox(height: 20.0),
                        FlatButton(
                          onPressed: _handleLogin,
                          child: Text('Login'),
                          color: Theme.of(context).accentColor,
                        ),
                      ],
                    )
                )
            )
        ),
    );
  }

  void _handleLogin() async {
    setState(() {
      isSpinning = true;
    });
    final user = await _firebaseService.login(emailController.value.text, passwordController.value.text);
    print(user.email);
    if (user != null) Navigator.pushNamed(context, DashBoardPage.route);
    else {
      setState(() {
        isSpinning = false;
      });
      final errorMessage = 'Anmeldung fehlgeschlagen';
      _showToast(errorMessage, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
    }
  }

  void _showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}
