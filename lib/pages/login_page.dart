import 'package:covid19_app/components/already_have_an_account_check.dart';
import 'package:covid19_app/components/background.dart';
import 'package:covid19_app/components/rounded_button.dart';
import 'package:covid19_app/components/rounded_input_field.dart';
import 'package:covid19_app/components/rounded_password_field.dart';
import 'package:covid19_app/pages/sign_up_page.dart';
import 'package:covid19_app/utils/services/authentication_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String errorMessage = '';
  String emailAddress = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.05),
              Container(
                child: Text(
                  "Logowanie",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
              ),
              SizedBox(height: size.height * 0.32),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.7,
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              SizedBox(height: 15),
              RoundedInputField(
                hintText: "Adres email",
                onChanged: (value) {
                  emailAddress = value;
                },
              ),
              SizedBox(height: size.height * 0.02),
              RoundedPasswordField(
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(height: size.height * 0.04),
              RoundedButton(
                text: "Zaloguj",
                press: () {
                  context
                      .read<AuthenticationProvider>()
                      .signIn(
                          email: emailAddress.trim(), password: password.trim())
                      .then((String result) {
                    if (context.read<User>() != null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HomePage();
                      }));
                    } else {
                      setState(() {
                        errorMessage = result;
                      });
                    }
                  });
                },
              ),
              SizedBox(height: size.height * 0.04),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpPage();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
