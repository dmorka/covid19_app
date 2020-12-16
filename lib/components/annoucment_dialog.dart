import 'package:covid19_app/components/rounded_button.dart';
import 'package:covid19_app/components/rounded_input_field.dart';
import 'package:covid19_app/core/consts.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/models/annoucement.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class AnnoucmentDialog extends StatelessWidget {
  AnnoucmentDialog({
    Key key,
  }) : super(key: key);

  final titleController = new TextEditingController();
  final descriptionController = new TextEditingController();
  final locationController = new TextEditingController();
  final dueDateController = new TextEditingController();

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
              RoundedInputField(
                hintText: "Czas dostarczenia",
                controller: dueDateController,
                icon: Icons.date_range_rounded,
              ),
              SizedBox(height: 25),
              RoundedButton(
                text: "ADD",
                press: () {
                  /*final announcement = new Annoucement(
                      "",
                      context.read<User>().uid,
                      titleController.text,
                      descriptionController.text,
                      dueDateController.text
                  );*/
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
