import 'package:flutter/material.dart';

class EagerVolunteersListItem extends StatelessWidget {
  final String name;
  final int recommendsCount;
  final int antiRecommendsCount;

  EagerVolunteersListItem(
      this.name, this.recommendsCount, this.antiRecommendsCount);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            // Action for accepting help from this volunteer (dialog box?).
              builder: (_) => null));
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
                      text: name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black87,
                        )
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      recommendsCount.toString(),
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      antiRecommendsCount.toString(),
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
}
