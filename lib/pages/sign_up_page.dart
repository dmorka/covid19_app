import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19_app/components/already_have_an_account_check.dart';
import 'package:covid19_app/components/background.dart';
import 'package:covid19_app/components/rounded_button.dart';
import 'package:covid19_app/components/rounded_input_field.dart';
import 'package:covid19_app/components/rounded_password_field.dart';
import 'package:covid19_app/utils/services/authentication_provider.dart';
import 'package:covid19_app/utils/services/firestore_service.dart';
import 'package:covid19_app/utils/services/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String errorMessage = '';
  final emailAddressController = new TextEditingController();
  final passwordController = new TextEditingController();

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
                  "Rejestracja",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
              ),
              SizedBox(height: size.height * 0.35),
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
                controller: emailAddressController,
              ),
              SizedBox(height: size.height * 0.02),
              RoundedPasswordField(
                controller: passwordController,
              ),
              SizedBox(height: size.height * 0.04),
              RoundedButton(
                text: "Zarejestruj",
                press: () {
                  if (emailAddressController.value.text == '' || passwordController.value.text == '') {
                    setState(() {
                      errorMessage = "Aby założyć konto musisz podać adres e-mail oraz hasło.";
                    });
                    return;
                  }
                  context
                      .read<AuthenticationProvider>()
                      .signUp(
                          email: emailAddressController.value.text.trim(),
                          password: passwordController.value.text.trim())
                      .then((String result) {
                    if (context.read<User>() != null) {
                      // FirebaseFirestoreService()
                      //     .addDeviceToken(context.read<User>().uid, "sfsdfds");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return new HomePage();
                        // return UserPersonalInfoEditPage();
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
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return new LoginPage();
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

  @override
  void dispose() {
    emailAddressController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
