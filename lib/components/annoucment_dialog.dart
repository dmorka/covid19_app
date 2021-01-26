import 'package:covid19_app/components/rounded_button.dart';
import 'package:covid19_app/components/rounded_input_field.dart';
import 'package:covid19_app/components/text_field_container.dart';
import 'package:covid19_app/core/consts.dart';
import 'package:covid19_app/models/address.dart';
import 'package:covid19_app/utils/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/models/annoucement.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:covid19_app/components/rounded_datetime_input_field.dart';

class AnnouncementDialog extends StatefulWidget {
  AnnouncementDialog({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnnouncementDialog();
}

class _AnnouncementDialog extends State<AnnouncementDialog> {
  _AnnouncementDialog();
  String errorMessage = '';
  final RegExp zipCodeRegExp = new RegExp(r"^$|\d{2}-\d{3}");
  final titleController = new TextEditingController(text: "");
  final descriptionController = new TextEditingController(text: "");
  final streetController = new TextEditingController(text: "");
  final apartmentNumberController = new TextEditingController(text: "");
  final zipCodeController = new TextEditingController(text: "");
  final cityController = new TextEditingController(text: "");
  var dueDate = DateTime.now();
  bool isChangeAddressVisible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      child: ListView(
        shrinkWrap: true,
        children: [
          Dialog(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Wrap(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 5,
                      runSpacing: 5,
                      children: <Widget>[
                        RoundedInputField(
                          hintText: "Tytuł",
                          controller: titleController,
                          icon: Icons.title,
                        ),
                        TextFieldContainer(
                          child: TextField(
                            minLines: 1,
                            maxLines: 6,
                            controller: descriptionController,
                            keyboardType: TextInputType.multiline,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.topic,
                                color: backgroundColor,
                              ),
                              hintText: "Opis",
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        RoundedDatetimeInputField(
                          hintText: "Czas dostarczenia",
                          icon: Icons.date_range,
                          onSaved: (date) => setState(() {
                            dueDate = date;
                          }),
                        ),
                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text('Użyj adresu podanego na profilu'),
                          value: !isChangeAddressVisible,
                          onChanged: (value) {
                            setState(() {
                              isChangeAddressVisible = !isChangeAddressVisible;
                            });
                          },
                          checkColor: Colors.white,
                          activeColor: mainColor,
                        ),
                        Visibility(
                          child: Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: [
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
                            ],
                          ),
                          visible: isChangeAddressVisible,
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
                          text: "Dodaj",
                          press: addAnnoucement,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void addAnnoucement() async {
    bool _isValid = true;
    setState(() {
      errorMessage = "";
    });
    if (isChangeAddressVisible){
      if (cityController.text == "") {
        setState(() {
          errorMessage = "City is required!";
        });
        _isValid = false;
      }
      if (!zipCodeRegExp.hasMatch(zipCodeController.text) || zipCodeController.text == "") {
        setState(() {
          errorMessage = "Zip code invalid format!";
        });
        _isValid = false;
      }
      if (apartmentNumberController.text == "") {
        setState(() {
          errorMessage = "Apartment is required!";
        });
        _isValid = false;
      }
      if (streetController.text == "") {
        setState(() {
          errorMessage = "Street is required!";
        });
        _isValid = false;
      }
    }
    if (titleController.text == "") {
      setState(() {
        errorMessage = "Title is required!";
      });
      _isValid = false;
    }
    if (descriptionController.text == "") {
      setState(() {
        errorMessage = "Description is required!";
      });
      _isValid = false;
    }
    if (_isValid) {
      String userId = context.read<User>().uid;
      AddressModel address;
      await getAddress(userId).then((value) => address = value);
      final announcement = new Annoucement(
        userId,
        titleController.text,
        descriptionController.text,
        dueDate,
        address,
      );
      FirebaseFirestoreService().createAnnoucement(announcement);
      Navigator.pop(context);
    }
  }

  Future<AddressModel> getAddress(userId) async {
    AddressModel addressModel;
    if (isChangeAddressVisible) {
      addressModel = new AddressModel(
          cityController.text,
          zipCodeController.text,
          streetController.text,
          apartmentNumberController.text);
    } else {
      await FirebaseFirestoreService()
          .getUser(userId)
          .then((value) => {addressModel = value.address});
    }

    return addressModel;
  }



}
