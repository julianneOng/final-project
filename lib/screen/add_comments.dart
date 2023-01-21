import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:convert';
import 'package:intl/intl.dart';

Future<CommentModel> addComment(int? commentId, int? postId, String comment, String alias, String createdAt) async {
  final response = await http.post(
    Uri.parse("https://63cb9d8cea85515415128b2b.mockapi.io/api/comments"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<dynamic, dynamic>{
      "commentId": commentId,
      "postId": postId,
      "comment": comment,
      "alias": alias,
      "createdAt": createdAt
    }),
  );

  if (response.statusCode == 201) {
    return CommentModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to Add Post');
  }
}

class CommentModel {
  int? commentId;
  int postId;
  String comment;
  String alias;
  String createdAt;

  CommentModel({this.commentId, required this.postId, required this.comment, required this.alias, required this.createdAt});

  factory CommentModel.fromMap(Map<String, dynamic> json) => CommentModel(
      commentId: json['commentId'], postId: json['postId'], comment: json["comment"], alias: json["alias"], createdAt: json["createdAt"]);

  Map<String, dynamic> toMap() => {
    "commentId": commentId,
    "postId": postId,
    "comment": comment,
    "alias": alias,
    "createdAt": createdAt
  };


  factory CommentModel.fromJson(Map<dynamic, dynamic> json) {
    return CommentModel(
      commentId: json['commentId'],
      postId: json['postId'],
      comment: json['comment'],
      alias: json['alias'],
      createdAt: json['createdAt'],
    );
  }
}

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
  List comments = <dynamic>[];
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('MM-dd-yyyy/HH:mm:ss').format(DateTime.now());

  @override
  void initState() {
    getPost();
    getComments();
    super.initState();
  }

  getPost() async {
    var url = 'https://63cb9d8cea85515415128b2b.mockapi.io/api/posts';
    var response = await http.get(Uri.parse(url));

    setState( () {
      post = convert.jsonDecode(response.body) as List<dynamic>;
    }
    );
  }

  getComments() async {
    var url = 'https://63cb9d8cea85515415128b2b.mockapi.io/api/comments';
    var response = await http.get(Uri.parse(url));

    setState( () {
      comments = convert.jsonDecode(response.body) as List<dynamic>;
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
      ),
      body: ListView.builder(
          itemCount: post.length,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: InkWell(
                child: Flexible(
                    child: ListView(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            child: Image.network(
                              "${post[widget.data-1]['avatar']}",
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(0),
                          title: Text(
                            "${post[widget.data-1]['user']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Text(
                            "${post[widget.data-1]['createdAt']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                              '${post[widget.data-1]['message']}'
                          ),
                        ),
                        const Divider(
                          height: 10,
                          thickness: 2,
                          indent: 5,
                          endIndent: 5,
                        ),
                        Form(
                            key: formKey,
                            child: ListView(
                              padding: const EdgeInsets.all(30),
                              children: [
                                TextFormField(
                                  controller: aliasController,
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                    labelText: "Alias",
                                    hintText: "Ex. The Ecologist",
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: commentController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    labelText: "Post Here",
                                    hintText: "How was your day?",
                                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                      setState(() {
                                        addComment(
                                            comments.lastIndexOf('postId', 0),
                                            widget.data-1,
                                            commentController.text,
                                            aliasController.text,
                                            formattedDate
                                        );
                                      });
                                      commentController.clear();
                                      aliasController.clear();
                                    },
                                    child: const Text("POST")
                                ),
                              ],
                            )
                        ),
                      ],
                    ),
                )

              ),
            );
          }
      ),
    );
  }
}
