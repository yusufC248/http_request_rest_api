import 'package:http/http.dart' as http;
import '../model/post_model.dart';

class ApiClientPost{
  static Future<List<Post>> getData(int page) async{
    Uri uri = Uri.parse("https://gits-msib.my.id/wp-json/wp/v2/posts?page=$page");
    try{
      final response = await http.get(uri);
      if(200 == response.statusCode){
        final List<Post> posts = postFromJson(response.body);
        return posts;
      }else{
        return List.empty();
      }
    }catch(e){
      return List.empty();
    }
  }
}