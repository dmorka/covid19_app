import 'package:covid19_app/components/rounded_button.dart';
import 'package:covid19_app/components/rounded_input_field.dart';
import 'package:covid19_app/core/consts.dart';
import 'package:flutter/material.dart';

class AnnoucmentDialog extends StatelessWidget {
  const AnnoucmentDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: 250,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RoundedInputField(
                hintText: "Description",
                icon: Icons.topic,
              ),
              SizedBox(height: 20),
              RoundedInputField(
                hintText: "Location",
                icon: Icons.add_location,
              ),
              SizedBox(height: 20),
              RoundedInputField(
                hintText: "Due date",
                icon: Icons.date_range_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
