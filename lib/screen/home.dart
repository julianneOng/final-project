import 'package:finalproject/csidebar/collapsible_sidebar.dart';
import 'package:finalproject/screen/create_post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'comments.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  List posts = <dynamic>[];
  int postId = 0;

  @override
  void initState() {
    getPosts();
    super.initState();
  }

  getPosts() async {
    var url = 'https://63cb9d8cea85515415128b2b.mockapi.io/api/posts';
    var response = await http.get(Uri.parse(url));

    setState( () {
      posts = convert.jsonDecode(response.body) as List<dynamic>;
    }
    );
  }

  @override void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Expanded(
                  flex: 1,
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: Colors.white54,
                        ),
                        icon: Icon(
                          Icons.search,
                          color: Colors.white54,
                        )
                    ),
                  ),
                )
              ],
            ),
          ),
          drawer: const NavBar(),
          body: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: InkWell(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          child: Image.network(
                            "${posts[index]['avatar']}",
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(
                          "${posts[index]['user']}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          "${posts[index]['createdAt']}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          '${posts[index]['message']}'
                        ),
                      ),
                      const Divider(
                        height: 10,
                        thickness: 2,
                        indent: 5,
                        endIndent: 5,
                      ),
                    ],
                  ),
                  onTap: () {
                      postId = int.parse(posts[index]['postId']);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Comments(data: int.parse(posts[index]['postId'])))
                      );
                  },
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreatePost())
              );
            },
            child: const Icon(Icons.add),
          ),
        )
    );
  }
}
