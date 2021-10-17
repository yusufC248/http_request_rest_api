import 'package:flutter/material.dart';
import '/model/search.dart';

class SearchScreen extends StatefulWidget {
  final List<Search>? search;
  final String query;

  const SearchScreen({Key? key, this.search, required this.query}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  Widget build(BuildContext context) {
    if(widget.search == null){
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "Hasil untuk pencarian '${widget.query}' tidak ditemukan",
          style: const TextStyle(
            fontSize: 18.0,
          ),
        ),
      );
    }
    return ListView.builder(
        itemBuilder: (BuildContext context, int index){
          Search search = widget.search![index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Text("ID : "+search.id.toString()),
                  Text(search.title.toString()),
                  Text("link: "+search.url.toString()),
                ]
              ),
            ),
          );
        },
        itemCount: widget.search!.length,
        );
  }
}
