
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {

  final Map content;

  ListItem(this.content);

  factory ListItem.withContent(Map) {
    return new ListItem(Map);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0)
      ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  content["name"],
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87
                  )
                ),
                SizedBox(height: 10),
                Text(
                  content["description"],
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 35),
                Text(
                  "Delivery time: " + content["when"],
                  style: const TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.right,
                ),
                Text(
                  "Where: " + content["where"],
                  style: const TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.normal
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
    }
}