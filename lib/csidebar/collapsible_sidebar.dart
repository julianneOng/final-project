import 'package:finalproject/csidebar/settings.dart';
import 'package:finalproject/screen/auth/login_page.dart';
import 'package:finalproject/screen/contact_us.dart';
import 'package:finalproject/screen/friends.dart';
import 'package:finalproject/screen/home.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  File? file;
  ImagePicker image = ImagePicker();

  late SharedPreferences logindata;
  late String username;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  @override void dispose(){
    super.dispose();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).canvasColor),
            accountName: const Text("default_username"),
            accountEmail: const Text('default_email@gmail.com'),
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
                              : Image.file(
                            file!,
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
                            color: Colors.green,
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
                                          return;
                                        }

                                        Navigator.of(ctx).pop();
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

                                        Navigator.of(ctx).pop();

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
                MaterialPageRoute(builder: (context) => const HomePage())
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Friends'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Friends())
              );
            },
          ),
          const ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Settings())
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
