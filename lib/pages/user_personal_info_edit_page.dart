import 'package:covid19_app/components/protected_container.dart';
import 'package:covid19_app/components/rounded_button.dart';
import 'package:covid19_app/components/rounded_input_field.dart';
import 'package:covid19_app/core/consts.dart';
import 'package:covid19_app/pages/user_profile_page.dart';
import 'package:flutter/material.dart';

class UserPersonalInfoEditPage extends StatefulWidget {
  @override
  _UserPersonalInfoEditState createState() => _UserPersonalInfoEditState();
}

class _UserPersonalInfoEditState extends State<UserPersonalInfoEditPage> {
  @override
  Widget build(BuildContext context) {
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
                              "Edit Personal Information",
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
                        hintText: "Jan",
                        onChanged: (value) {},
                      ),
                      RoundedInputField(
                        hintText: "Kowalski",
                        onChanged: (value) {},
                      ),
                      RoundedInputField(
                        hintText: "023 622 253",
                        icon: Icons.phone,
                        onChanged: (value) {},
                      ),
                      RoundedInputField(
                        hintText: "jkowalski@example.com",
                        icon: Icons.email_outlined,
                        onChanged: (value) {},
                      ),
                      RoundedInputField(
                        hintText: "ul. Kościelna 67 m.106, 00-001 Warszawa",
                        icon: Icons.location_pin,
                        onChanged: (value) {},
                      ),
                      SizedBox(height: 15),
                      RoundedButton(
                        text: "SAVE",
                        color: mainColor,
                        press: () {
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
}
