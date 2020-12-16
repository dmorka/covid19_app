
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    Key key,
    this.listener
  }) : super(key: key);

  final void Function() listener;

  @override
  State<StatefulWidget> createState() => SearchWidgetState(listener);
}

class SearchWidgetState extends State<SearchWidget> {
  TextEditingController _textEditingController = TextEditingController();
  bool _isSearching = false;
  String _searchQuery = "";
  String get searchQuery => _searchQuery;

  SearchWidgetState(void Function() listener) {
    _textEditingController.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      autofocus: false,
      decoration: InputDecoration(
        hintText: "Wyszukaj",
        border: InputBorder.none,
        hintStyle: TextStyle(
            color: Colors.white30
        )
      ),
      style: TextStyle(
        color: Colors.white,
        fontSize: 16
      ),
      onChanged: (query) => setState(() {
        _searchQuery = query;
      }),
    );
  }

}