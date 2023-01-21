import 'package:flutter/material.dart';
import 'package:finalproject/util/data.dart';

class Friends extends StatefulWidget {
  const Friends({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextField(
          decoration: InputDecoration.collapsed(
            hintText: 'Search',
            hintStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.filter_list,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        separatorBuilder: (BuildContext context, int index) {
          return Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 0.5,
              width: MediaQuery.of(context).size.width / 1.3,
              child: const Divider(),
            ),
          );
        },
        itemCount: friends.length,
        itemBuilder: (BuildContext context, int index) {
          Map friend = friends[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                  friend['dp'],
                ),
                radius: 25,
              ),
              contentPadding: const EdgeInsets.all(0),
              title: Text(friend['name']),
              subtitle: Text(friend['status']),
              trailing: friend['isAccept']
                  ? TextButton(
                    child: const Text(
                      "Unfollow",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    // color: Colors.grey,
                    onPressed: () {},
                  )
                  : TextButton(
                    child: const Text(
                      "Follow",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    // color: Theme.of(context).accentColor,
                    onPressed: () {},
                  ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
