import 'dart:io';
import 'package:covid19_app/components/avatar_dialog.dart';
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
import 'package:path_provider/path_provider.dart';
import 'package:covid19_app/components/avatar.dart';

class UserPersonalInfoEditPage extends StatefulWidget {
  @override
  _UserPersonalInfoEditState createState() => _UserPersonalInfoEditState();
}

class _UserPersonalInfoEditState extends State<UserPersonalInfoEditPage> {
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


  // _UserPersonalInfoEditState() {
  //   getAvatar().then((value) => setState(() {
  //         avatar = value;
  //         print(value);
  //       }));
  // }

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
                          FutureBuilder<File>(
                              future: getAvatar(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) print(snapshot.error);

                                return AvatarWidget(avatar: snapshot.data);

                              }),
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
                      hintText: "Numer telefonu",
                      controller: phoneNumberController,
                      icon: Icons.smartphone,
                    ),
                    SizedBox(height: 15),
                    RoundedButton(
                      text: "SAVE",
                      color: mainColor,
                      press: () {
                        if (!phoneRegExp.hasMatch(phoneNumberController.text)) {
                          phoneNumberController.text = "Invalid format!";
                          return;
                        }
                        if (!zipCodeRegExp.hasMatch(zipCodeController.text)) {
                          zipCodeController.text = "Invalid format!";
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
                            phoneNumberController.text);
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<File> getAvatar() async {
    final directory = await getApplicationDocumentsDirectory();
    String dir = directory.path;
    return File('$dir/profile.jpg');
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

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    Key key,
    @required this.avatar,
  }) : super(key: key);

  final File avatar;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      margin: const EdgeInsets.all(16),
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.white, width: 5),
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: avatar == null ? AssetImage("assets/images/profile.jpg") : FileImage(avatar),
        ),
      ),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.purple[300], width: 4),
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
