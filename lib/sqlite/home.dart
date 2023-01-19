import 'package:finalproject/csidebar/collapsible_sidebar.dart';
import 'package:finalproject/sqlite/create_group.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState(){
    super.initState();
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
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  child: Text("Home"),
                ),
                Tab(
                  child: Text("Popular"),
                ),
              ],
            ),
          ),
          drawer: const NavBar(),
          body: const Center(
            child: Text("Hello Reddit"),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateGroup())
              );
            },
            child: const Icon(Icons.add),
          ),
        )
    );
  }
}
