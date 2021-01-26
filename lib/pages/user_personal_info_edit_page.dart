import 'dart:io';
import 'package:covid19_app/components/avatar_dialog.dart';
import 'package:covid19_app/components/protected_container.dart';
import 'package:covid19_app/components/rounded_button.dart';
import 'package:covid19_app/components/rounded_input_field.dart';
import 'package:covid19_app/core/consts.dart';
import 'package:covid19_app/models/address.dart';
import 'package:covid19_app/models/user.dart';
import 'package:covid19_app/pages/user_profile_page.dart';
import 'package:covid19_app/utils/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:covid19_app/utils/services/storage_service.dart';

class UserPersonalInfoEditPage extends StatefulWidget {
  @override
  _UserPersonalInfoEditState createState() => _UserPersonalInfoEditState();
}

class _UserPersonalInfoEditState extends State<UserPersonalInfoEditPage> {
  String errorMessage = '';
  String id;
  final RegExp phoneRegExp =
      new RegExp(r"^[\+]?[(]?[0-9]{2}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$");
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
    Size size = MediaQuery.of(context).size;
    if (!areValuesInitialized) {
      FirebaseFirestoreService()
          .getUser(context.watch<User>().uid)
          .then((value) => setTextFieldInitValues(value));
      areValuesInitialized = true;
    }
    return ProtectedContainer(
      body: Scaffold(
        backgroundColor: backgroundColor,
        body: Builder(
          builder: (context) => SingleChildScrollView(
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
                          FutureBuilder<String>(
                              future: FirebaseStorageService()
                                  .setAvatar(context.read<User>().uid),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) print(snapshot.error);

                                return new AvatarWidget(avatar: snapshot.data);
                              }),
                          Flexible(child: Container(
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
                          ),)
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Column(
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
                      hintText: "Numer budynku",
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
                      hintText: "Numer telefonu",
                      controller: phoneNumberController,
                      icon: Icons.smartphone,
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      width: size.width * 0.7,
                      child: Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    SizedBox(height: 10),
                    RoundedButton(
                      text: "ZAPISZ",
                      color: mainColor,
                      press: setUser,
                    ),
                    SizedBox(height: 20)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setUser() {
    bool _isValid = true;
    setState(() {
      errorMessage = "";
    });
    if (cityController.text == "") {
      setState(() {
        errorMessage = "Miasto jest wymagane!";
      });
      _isValid = false;
    }
    if (firstNameController.text == "") {
      setState(() {
        errorMessage = "Imię jest wymagane!";
      });
      _isValid = false;
    }
    if (lastNameController.text == "") {
      setState(() {
        errorMessage = "Nazwisko jest wymagane!";
      });
      _isValid = false;
    }
    if (apartmentNumberController.text == "") {
      setState(() {
        errorMessage = "Nr mieszkania jest wymagane!";
      });
      _isValid = false;
    }
    if (streetController.text == "") {
      setState(() {
        errorMessage = "Ulica jest wymagana!";
      });
      _isValid = false;
    }
    if (!phoneRegExp.hasMatch(phoneNumberController.text) || phoneNumberController.text == "") {
      setState(() {
        errorMessage = "Nr telefonu ma zły format!";
      });
      _isValid = false;
    }
    if (!zipCodeRegExp.hasMatch(zipCodeController.text) || zipCodeController.text == "") {
      setState(() {
        errorMessage = "Kod pocztowy ma zły format!";
      });
      _isValid = false;
    }
    if (_isValid) {
      final UserModel user = new UserModel(
        context
            .read<User>()
            .uid,
        firstNameController.text,
        lastNameController.text,
        phoneNumberController.text,
        new AddressModel(
          cityController.text,
          zipCodeController.text,
          streetController.text,
          apartmentNumberController.text,
        ),
      );
      FirebaseFirestoreService()
          .updateUser(user);

      Navigator.pop(context);

      /*Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => new UserProfilePage()),
      );*/
    }
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
      streetController.text = value.address.street;
      apartmentNumberController.text = value.address.apartmentNumber;
      zipCodeController.text = value.address.zipCode;
      cityController.text = value.address.city;
      phoneNumberController.text = value.phoneNumber;
    }
  }
}

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    Key key,
    @required this.avatar,
  }) : super(key: key);

  final String avatar;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          image: avatar == null
              ? AssetImage("assets/images/profile.jpg")
              : NetworkImage(avatar),
        ),
      ),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.purple[300], width: 4),
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        child: IconButton(
          icon: Icon(Icons.edit),
          iconSize: 28,
          color: Colors.white,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AvatarDialog();
                });
          },
        ),
      ),
    );
  }
}
