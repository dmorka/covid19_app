import 'package:covid19_app/core/consts.dart';
import 'package:flutter/material.dart';

class AnnoucmentDialog extends StatelessWidget {
  const AnnoucmentDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'What do you want to remember?'),
              ),
              SizedBox(
                width: 320.0,
                child: RaisedButton(
                  onPressed: () {},
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: const Color(0xFF1BC0C5),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
