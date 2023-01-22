import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class DisplayComments extends StatefulWidget {

  final List data;
  const DisplayComments({
    required this.data,
    Key? key}) : super(key: key);

  @override
  State<DisplayComments> createState() => _DisplayCommentsState();
}

class _DisplayCommentsState extends State<DisplayComments> {

  List comments = <dynamic>[];
  late List postComment = <dynamic>[];
  int currentIndex = 0;

  @override
  void initState() {
    getComments();
    displayComments();
    super.initState();
  }

  getComments() async {
    var url = 'https://63cb9d8cea85515415128b2b.mockapi.io/api/comments';
    var response = await http.get(Uri.parse(url));

    setState( () {
      comments = convert.jsonDecode(response.body) as List<dynamic>;
    });
    }

  displayComments() async {
    postComment = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
      ),
      body: ListView.builder(
          itemCount: postComment.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text("${postComment[index]['commentId']}"),
              onTap: (){
                Navigator.pop(context);
              },
            );
          }
          ),
    );
  }
}
