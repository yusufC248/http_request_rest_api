import 'package:flutter/material.dart';
import '../common/app_route.dart';
import '../model/user.dart';
import '../provider/user_provider.dart';
import 'package:provider/provider.dart';
import '../model/post_model.dart';
import '../network/api_client_post.dart';

class DisplayPost extends StatefulWidget {
  final User? user;
  const DisplayPost({Key? key, this.user}) : super(key: key);

  @override
  _DisplayPostState createState() => _DisplayPostState();
}

class _DisplayPostState extends State<DisplayPost> {
  List<Post>? _post;
  late bool _loading;
  int page = 1;
  final ScrollController _controller = ScrollController();


  @override
  void initState(){
    super.initState();
    _requestNewData();
      _controller.addListener(() {
        double _pixels = _controller.position.pixels;
        double _maxScroll = _controller.position.maxScrollExtent;
        if (_pixels == _maxScroll){
         _requestNewData();
        }
      });
  }

  Future<void> _requestNewData() async{
    _loading = true;
    ApiClientPost.getData(page).then((value){
      _post = value;
      _loading = false;
      page += 1;
        setState(() {});
    });
  }

  Widget _logoutButton(){
    return  Consumer<UserProvider>(
      builder: (context, usp, child) =>
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            ),
            onPressed: (){
              usp.logout(widget.user!.token);
              Navigator.pushReplacementNamed(
                  context, AppRoute.homeRoute
              );
            },
            child: const Text("LOGOUT",
              style: TextStyle(color: Colors.white),
            ),
          ),
    );
  }

  Widget _loginButton(){
    return ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen),
            ),
            onPressed: (){
              Navigator.pushReplacementNamed(
                  context, AppRoute.loginRoute
              );
            },
            child: const Text("LOGIN",
              style: TextStyle(color: Colors.white),
            ),
        );
    }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(_loading ? 'Loading..': 'GITS ID Blog'),
              widget.user!=null ? _logoutButton() : _loginButton(),
            ],
          ),
        ),
        body: ListView.builder(
            shrinkWrap: true,
            controller: _controller,
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
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(post.title!.rendered.toString(),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text("link: "+post.link.toString(),
                          style: const TextStyle(fontSize: 15),
                        ),
                        Text("Post date: "+post.date.toString(),
                          style: const TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })
    );
  }
}
