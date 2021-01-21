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

  final titleController = new TextEditingController();
  final descriptionController = new TextEditingController();
  final locationController = new TextEditingController();
  final streetController = new TextEditingController();
  final apartmentNumberController = new TextEditingController();
  final zipCodeController = new TextEditingController();
  final cityController = new TextEditingController();
  var dueDate = DateTime.now();
  bool isChangeAddressVisible = false;

  @override
  Widget build(BuildContext context) {
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
                        RoundedButton(
                          text: "Dodaj",
                          press: () {
                            final announcement = new Annoucement(
                              context.read<User>().uid,
                              titleController.text,
                              descriptionController.text,
                              dueDate,
                              new AddressModel(
                                cityController.text,
                                zipCodeController.text,
                                streetController.text,
                                apartmentNumberController.text,
                              ),
                            );
                            FirebaseFirestoreService()
                                .createAnnoucement(announcement);
                            Navigator.pop(context);
                          },
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
}
