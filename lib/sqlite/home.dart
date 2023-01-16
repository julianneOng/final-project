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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
      ),
      drawer: const NavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateGroup())
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
