import 'package:flutter/material.dart';
import 'package:http_request_rest_api/model/post_model.dart';
import 'package:http_request_rest_api/network/api_client_post.dart';

class DisplayPost extends StatefulWidget {
  const DisplayPost({Key? key}) : super(key: key);

  @override
  _DisplayPostState createState() => _DisplayPostState();
}

class _DisplayPostState extends State<DisplayPost> {
  List<Post>? _post;
  late bool _loading;

  @override
  void initState(){
    super.initState();
    _loading = true;
    ApiClientPost.getData().then((value){
      setState(() {
        _post = value;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(_loading ? 'Loading..': 'Post'),
              ElevatedButton(
                onPressed: (){},
                child: Text("LOGOUT"),
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Scrollbar(
            isAlwaysShown: true,
            child: Column(
              children: <Widget>[
                Text("GITS ID Blog",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: null == _post ? 0 : _post!.length,
                      itemBuilder: (context, index){
                        Post post = _post![index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(post.title!.rendered.toString(),
                                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                  ),
                                  Text("link: "+post.link.toString(),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text("Post date: "+post.date.toString(),
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        )
    );
  }
}
