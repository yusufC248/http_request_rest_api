import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/post_model.dart';
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
