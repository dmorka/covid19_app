import 'package:covid19_app/components/rounded_button.dart';
import 'package:covid19_app/components/rounded_input_field.dart';
import 'package:covid19_app/core/consts.dart';
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
  var dueDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: 330,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RoundedInputField(
                hintText: "Tytuł",
                controller: titleController,
                icon: Icons.title,
              ),
              SizedBox(height: 20),
              RoundedInputField(
                hintText: "Opis",
                controller: descriptionController,
                icon: Icons.topic,
              ),
              SizedBox(height: 20),
              RoundedDatetimeInputField(
                hintText: "Czas dostarczenia",
                icon: Icons.date_range,
                onSaved: (date) => setState(() {
                  dueDate = date;
                }),
              ),
              SizedBox(height: 25),
              RoundedButton(
                text: "Dodaj",
                press: () {
                  final announcement = new Annoucement(
                      context.read<User>().uid,
                      titleController.text,
                      descriptionController.text,
                      dueDate
                  );
                  FirebaseFirestoreService().createAnnoucement(announcement);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
