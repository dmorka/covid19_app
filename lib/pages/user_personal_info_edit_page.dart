import 'package:covid19_app/components/protected_container.dart';
import 'package:covid19_app/components/rounded_button.dart';
import 'package:covid19_app/components/rounded_input_field.dart';
import 'package:covid19_app/core/consts.dart';
import 'package:covid19_app/models/user.dart';
import 'package:covid19_app/pages/user_profile_page.dart';
import 'package:covid19_app/utils/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPersonalInfoEditPage extends StatefulWidget {
  @override
  _UserPersonalInfoEditState createState() => _UserPersonalInfoEditState();
}

class _UserPersonalInfoEditState extends State<UserPersonalInfoEditPage> {
  String id;
  final RegExp phoneRegExp = new RegExp(r"^[\+]?[(]?[0-9]{2}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$");
  final RegExp zipCodeRegExp = new RegExp(r"^$|\d{2}-\d{3}");
  final firstNameController = new TextEditingController();
  final lastNameController = new TextEditingController();
  final streetController = new TextEditingController();
  final apartmentNumberController = new TextEditingController();
  final zipCodeController = new TextEditingController();
  final cityController = new TextEditingController();
  final phoneNumberController = new TextEditingController();
  bool areValuesInitialized = false;
  @override
  Widget build(BuildContext context) {
    if (!areValuesInitialized) {
      FirebaseFirestoreService()
          .getUser(context.watch<User>().uid)
          .then((value) => setTextFieldInitValues(value));
      areValuesInitialized = true;
    }

    return ProtectedContainer(
      body: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  padding: EdgeInsets.only(top: 25, bottom: 30),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: <Widget>[
                      Image.asset("assets/images/virus2.png"),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.bottomRight,
                            margin: const EdgeInsets.all(16),
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 5),
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/profile.jpg"),
                              ),
                            ),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.purple[300], width: 4),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                              ),
                              child: Icon(
                                Icons.edit_rounded,
                                color: Colors.purple[100],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Edytowanie danych osobowych",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RoundedInputField(
                        hintText: "Imię",
                        controller: firstNameController,
                      ),
                      RoundedInputField(
                        hintText: "Nazwisko",
                        controller: lastNameController,
                      ),
                      RoundedInputField(
                        hintText: "Ulica",
                        controller: streetController,
                        icon: Icons.location_pin,
                      ),
                      RoundedInputField(
                        hintText: "Numer budynku/mieszkania",
                        controller: apartmentNumberController,
                        icon: Icons.location_pin,
                      ),
                      RoundedInputField(
                        hintText: "Kod pocztowy",
                        controller: zipCodeController,
                        icon: Icons.location_pin,
                      ),
                      RoundedInputField(
                        hintText: "Miasto",
                        controller: cityController,
                        icon: Icons.location_pin,
                      ),
                      RoundedInputField(
                        regExp: r"^[\+]?[(]?[0-9]{2}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$",
                        hintText: "Numer telefonu",
                        controller: phoneNumberController,
                        icon: Icons.smartphone,
                      ),
                      SizedBox(height: 15),
                      RoundedButton(
                        text: "SAVE",
                        color: mainColor,
                        press: () {
                          if(!phoneRegExp.hasMatch(phoneNumberController.text)) {
                            phoneNumberController.text =
                            "Invalid format!";
                            return;
                          }
                          if(!zipCodeRegExp.hasMatch(zipCodeController.text)) {
                            zipCodeController.text =
                            "Invalid format!";
                            return;
                          }
                          final UserModel user = new UserModel(
                            context.read<User>().uid,
                            firstNameController.text,
                            lastNameController.text,
                            cityController.text,
                            zipCodeController.text,
                            streetController.text,
                            apartmentNumberController.text,
                            phoneNumberController.text
                          );
                          FirebaseFirestoreService().updateUser(user);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return UserProfilePage();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    streetController.dispose();
    apartmentNumberController.dispose();
    zipCodeController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void setTextFieldInitValues(UserModel value) {
    if (value != null) {
      firstNameController.text = value.firstName;
      lastNameController.text = value.lastName;
      streetController.text = value.street;
      apartmentNumberController.text = value.apartmentNumber;
      zipCodeController.text = value.zipCode;
      cityController.text = value.city;
      phoneNumberController.text = value.phoneNumber;
    }
  }
}
