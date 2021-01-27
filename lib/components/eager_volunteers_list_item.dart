import 'package:covid19_app/models/annoucement.dart';
import 'package:covid19_app/models/volunteer.dart';
import 'package:covid19_app/utils/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class EagerVolunteersListItem extends StatefulWidget {
  final VolunteerModel _volunteer;
  final Annoucement _annoucement;

  EagerVolunteersListItem(this._volunteer, this._annoucement);

  @override
  _EagerVolunteersListItemState createState() => _EagerVolunteersListItemState();
}

class _EagerVolunteersListItemState extends State<EagerVolunteersListItem> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (_) => _createAlertDialog());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black12
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: RichText(
                        text: TextSpan(
                          text: widget._volunteer.firstName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.black87,
                            )
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          widget._volunteer.recommendations.where((e) => e == true).length.toString(),
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          widget._volunteer.recommendations.where((e) => e == false).length.toString(),
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ]
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Text(
                  "user ID: " + widget._volunteer.id,
                  style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.normal
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  AlertDialog _createAlertDialog() {
    return AlertDialog(
      title: Text("Potwierdzenie przyjęcia pomocy"),
      content: Text("Czy na pewno chcesz przyjąć pomoc od " + widget._volunteer.firstName + "?"),
      actions: [
        FlatButton(
          child: Text("Tak, przyjmuję"),
          onPressed: () {
            setState(() {
              widget._annoucement.confirmed = true;
              widget._annoucement.volunteers = [widget._volunteer.id];
            });
            FirebaseFirestoreService()
              .updateAnnoucement(widget._annoucement);
            /*Navigator.of(context)
                .popUntil(ModalRoute.withName('/user-profile'));*/
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Nie"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
