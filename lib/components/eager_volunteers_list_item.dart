import 'package:covid19_app/models/volunteer.dart';
import 'package:flutter/material.dart';

class EagerVolunteersListItem extends StatefulWidget {
  final VolunteerModel _volunteer;

  EagerVolunteersListItem(this._volunteer);

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
          child: Container(
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
            // Call Firebase to accept the announcement

            Navigator.of(context)
                .popUntil(ModalRoute.withName('/user-profile'));
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
