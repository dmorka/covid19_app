import 'package:covid19_app/components/text_field_container.dart';
import 'package:covid19_app/core/consts.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key key, this.searchQueryListener}) : super(key: key);

  final void Function(String query) searchQueryListener;

  @override
  State<StatefulWidget> createState() =>
      _SearchWidgetState(searchQueryListener);
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController _textEditingController = TextEditingController();
  bool _isSearching = false;
  String _searchQuery = "";
  void Function(String query) _searchQueryListener;

  _SearchWidgetState(void Function(String query) listener) {
    _searchQueryListener = listener;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFieldContainer(
        backgroundColor: Color.fromRGBO(206, 147, 216, 0.5),
        child: TextField(
          controller: _textEditingController,
          autofocus: false,
          decoration: InputDecoration(
              hintText: "Wyszukaj",
              hintStyle: TextStyle(color: Colors.white70),
              border: InputBorder.none,
              icon: Icon(
                Icons.search,
                color: backgroundColor,
              ),
              suffixIcon: IconButton(
                  onPressed: () {
                    _textEditingController.clear();
                    _searchQuery = "";
                    _searchQueryListener(_searchQuery);
                  },
                  icon: Icon(
                    Icons.clear,
                    color: backgroundColor,
                  ))),
          style: TextStyle(color: Colors.white, fontSize: 16),
          onChanged: (query) => setState(() {
            _searchQuery = query;
            _searchQueryListener(_searchQuery);
          }),
        ),
      ),
    );
  }
}
