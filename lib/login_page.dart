import 'package:flutter/material.dart';
import 'sqlite/data_model.dart';
import 'sqlite/database.dart';
import 'sqlite/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  List<DataModel> data = [];
  bool fetching = true;
  int currentIndex = 0;
  // bool _obscureText = true;

  // String? _password;
  //
  // void _toggle() {
  //   setState(() {
  //     _obscureText = !_obscureText;
  //   });
  // }

  late DB db;

  @override
  void initState() {
    super.initState();
    db = DB();
    db.initDB();
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
        leading: const Icon(Icons.handshake),
        title: const Text("KoneK"),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: userNameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                  labelText: "Username"
              ),
              validator: (value){
                return (value == '')? "Input Name" : null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                )
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()
                      )
                  );
                },
                child: const Text("Log In")
            ),
            TextButton(
                onPressed: (){
              showMyDialogue();
              },
                child: const Text("Create Account")
            )
          ]
        )
      )
    );
  }

  void showMyDialogue() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: const Text('Create Account'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: firstNameController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          labelText: "First Name"),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: lastNameController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          labelText: "Last Name"),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: userNameController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          labelText: "Username"),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          labelText: "Password"),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          labelText: "Email Address"),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  DataModel dataLocal = DataModel(
                    firstname: firstNameController.text,
                    lastname: lastNameController.text,
                    username: userNameController.text,
                    password: passwordController.text,
                    email: emailController.text,
                  );
                  await db.insertData(dataLocal);
                  dataLocal.id = data[data.length - 1].id! + 1;
                  setState(() {
                    data.add(dataLocal);
                  });
                  firstNameController.clear();
                  lastNameController.clear();
                  userNameController.clear();
                  passwordController.clear();
                  emailController.clear();
                  Navigator.pop(context);
                },
                child: const Center(
                  child: Text("Sign Up"),
                ),
              ),
            ],
          );
        });
  }


}

