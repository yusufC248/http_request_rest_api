import 'package:flutter/material.dart';
import '../API/api_service.dart';
import '../model/search.dart';
import '../ui/search_display_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<Search>? _search;
  bool _onSearch = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
        controller: _controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
        hintText: 'Ketik Disini',
        suffixIcon: IconButton(
        onPressed: _searchPost,
        icon: const Icon(Icons.search),
        ),
          border: InputBorder.none,
        ),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          autofocus: true,
          onEditingComplete: _searchPost,
      ),
      ),
      body: _body(),
    );
  }

  Future<void> _searchPost() async {
    setState(() {_onSearch = true;});
    _search = await ApiSearch.getData(_controller.text);
    setState(() {_onSearch = false;});
  }

  Widget _body(){
    if(_onSearch){
      return Center(
        child: Column(
          children: const <Widget>[
            Text("Cari Keyword Postingan"),
            CircularProgressIndicator(),
          ],
        ),
      );
    }else{
      return SearchScreen(
          search: _search,
          query: _controller.text);
    }
  }

}
