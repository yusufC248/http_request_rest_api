import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/search.dart';
import '../model/user.dart';

class ApiService {
  static const String _baseUrl = 'https://gits-msib.my.id/wp-json';


  static Future<User?> login(
    http.Client client,
    String username,
    String password,
  ) async {
    var body = {'username': username, 'password': password};

    final response = await client.post(
      Uri.parse(_baseUrl + "/jwt-auth/v1/token"),
      body: body,
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }
}

class ApiSearch{
  static Future<List<Search>> getData(String? query) async{
    Uri uri = Uri.parse("https://gits-msib.my.id/wp-json/wp/v2/search?search=$query");
    try{
      final response = await http.get(uri);
      if(200 == response.statusCode){
        final List<Search> search = searchFromJson(response.body);
        return search;
      }else{
        return List.empty();
      }
    }catch(e){
      return List.empty();
    }
  }
}

