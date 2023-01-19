import 'package:finalproject/csidebar/collapsible_sidebar.dart';
import 'package:finalproject/sqlite/create_post.dart';
import 'package:finalproject/widget/post_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finalproject/util/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences logindata;
  late String username;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }
  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
    });
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
            itemBuilder: (BuildContext context, int index) {
              Map post = posts[index];
              return PostItem(
                img: post['img'],
                name: post['name'],
                dp: post['dp'],
                time: post['time'],
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
