import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text(
            "PESQUISAR",
          ),
          suffixIcon: Icon(Icons.search)),
      onChanged: null,
    );
  }
}
