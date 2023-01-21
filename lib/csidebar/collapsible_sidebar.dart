import 'package:finalproject/csidebar/settings.dart';
import 'package:finalproject/screen/auth/login_page.dart';
import 'package:finalproject/csidebar/contact_us.dart';
import 'package:finalproject/csidebar/friends.dart';
import 'package:finalproject/screen/home.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NavBar extends StatefulWidget {

  final int data;
  const NavBar({
    required this.data,
    Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  File? file;
  ImagePicker image = ImagePicker();
  List users = <dynamic>[];
  late SharedPreferences loginData;
  late String username;
  List user = <dynamic>[];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    initial();
    getUsers();
  }
  

  getUsers() async {
    var url = 'https://63c95a0e320a0c4c9546afb1.mockapi.io/api/users';
    var response = await http.get(Uri.parse(url));

    setState( () {
      users = convert.jsonDecode(response.body) as List<dynamic>;
    }
    );
  }
  
  getUser() async {
    for (var i = 0; i <= users.length; i++) {
      if (widget.data == users[i]['id']) {
        setState(() {
          currentIndex = widget.data-1;
        });
        break;
      }
    }
  }

  @override void dispose(){
    super.dispose();
  }

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      username = loginData.getString('username')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).canvasColor),
            accountName: Text("${users[currentIndex]['username']}"),
            accountEmail: Text('${users[currentIndex]['email']}'),
            currentAccountPicture: CircleAvatar(
              child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.black,
                      child: ClipOval(
                        child: SizedBox(
                          width: 150.0,
                          height: 100.0,
                          child: file == null
                              ? const Icon(
                            Icons.image,
                            size: 50,
                          )
                              : Image.network(
                            "${users[currentIndex]['avatar']}",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    //use Positioned
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            // padding: const EdgeInsets.all(15),
                            icon: const Icon(Icons.camera_alt),
                            color: Colors.white,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("Please choose"),
                                  content: const Text("From:"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () async {
                                        // getCam();
                                        PermissionStatus cameraStatus = await Permission.camera.request();
                                        if (cameraStatus == PermissionStatus.granted) {
                                          getCam(ImageSource.camera);
                                        } else if (cameraStatus == PermissionStatus.denied) {
                                          return ;
                                        }

                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        child: const Text("Camera"),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        // getGall();
                                        PermissionStatus cameraStatus = await Permission.storage.request();
                                        if (cameraStatus == PermissionStatus.granted) {
                                          getGall(ImageSource.gallery);
                                        } else if (cameraStatus == PermissionStatus.denied) {
                                          return;
                                        }

                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        child: const Text("Gallery"),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        child: const Text("Cancel"),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ]
              )
            )
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text ('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage(data: widget.data))
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings(data: widget.data))
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Contact Us'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactUs())
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Log Out'),
            leading: const Icon(Icons.logout_sharp),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage())
              );
            },
          ),
        ],
      ),
    );
  }
  getCam(ImageSource source) async {
    // ignore: deprecated_member_use
    var img = await image.getImage(source: ImageSource.camera);
    setState(() {
      file = File(img!.path);
    });
  }

  getGall(ImageSource source) async {
    // ignore: deprecated_member_use
    var img = await image.getImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });
  }
}
