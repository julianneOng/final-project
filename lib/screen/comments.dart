import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class Comments extends StatefulWidget {

  final int data;
  const Comments({
    required this.data,
    Key? key}) : super(key: key);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final TextEditingController commentController = TextEditingController();
  final TextEditingController aliasController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  List post = <dynamic>[];

  @override
  void initState() {
    getPost(widget.data);
    super.initState();
  }

  getPost(int id) async {
    var url = 'https://63cb9d8cea85515415128b2b.mockapi.io/api/posts/$id';
    var response = await http.get(Uri.parse(url));

    setState( () {
      post = convert.jsonDecode(response.body) as List<dynamic>;
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('$post'),
          )
        ],
      ),
    );
  }
}
