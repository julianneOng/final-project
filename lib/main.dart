import 'package:finalproject/screen/auth/login_page.dart';
import 'package:flutter/material.dart';


void main() {
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Anonymity',
    theme: ThemeData.dark(),
    home: const LoginPage(),
    )
  );
}

