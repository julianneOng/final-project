import 'package:flutter/material.dart';
import 'package:finalproject/util/data.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Us"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: group.length,
        itemBuilder: (BuildContext context, int index) {
          Map groups = group[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                  groups['dp'],
                ),
                radius: 25,
              ),
              contentPadding: const EdgeInsets.all(0),
              title: Text(groups['name']),
              subtitle: Text(groups['status']),
            ),
          );
        },
      ),
    );
  }
}
