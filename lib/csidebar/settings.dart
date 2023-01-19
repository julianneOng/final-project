import 'package:finalproject/sqlite/data_model.dart';
import 'package:finalproject/sqlite/database.dart';
import 'package:flutter/material.dart';
import '../sqlite/create_account.dart';
import 'collapsible_sidebar.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  List<DataModel> data = [];
  bool fetching = true;
  int currentIndex = 0;

  late DB db;
  @override
  void initState() {
    super.initState();
    db = DB();
    getData2();
  }

  void getData2() async {
    data = await db.getData();
    setState(() {
      fetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Database"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: const Icon(Icons.add),
      ),
      body: fetching
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) => DataCard(
          data: data[index],
          edit: edit,
          index: index,
          delete: delete,
        ),
      ),
      drawer: const NavBar(),
    );
  }
  void popUpdate() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(14),
            content: SizedBox(
              height: 150,
              child: Column(
                children: [
                  TextFormField(
                    controller: userNameController,
                    decoration: const InputDecoration(labelText: "Username"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: "Email"),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  DataModel newData = data[currentIndex];
                  newData.firstname = firstNameController.text;
                  newData.lastname = lastNameController.text;
                  newData.username = userNameController.text;
                  newData.password = passwordController.text;
                  newData.email = emailController.text;
                  db.update(newData, newData.id!);
                  setState(() {});
                  Navigator.pop(context);
                },
                child: const Text("Update"),
              ),
            ],
          );
        });
  }

  void edit(index) {
    currentIndex = index;
    firstNameController.text = data[index].firstname;
    lastNameController.text = data[index].lastname;
    userNameController.text = data[index].username;
    passwordController.text = data[index].password;
    emailController.text = data[index].email;
    popUpdate();
  }

  void delete(int index) {
    db.delete(data[index].id!);
    setState(() {
      data.removeAt(index);
    });
  }
}