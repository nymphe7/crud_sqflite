import 'package:crudy/screen/crudbdy.dart';
import 'package:crudy/screen/home.dart';
import 'package:flutter/material.dart';

import 'database/database.dart';
import 'model/contact.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Crudy());
}

class Crudy extends StatefulWidget {
  const Crudy({Key? key}) : super(key: key);

  @override
  _CrudyState createState() => _CrudyState();
}

class _CrudyState extends State<Crudy> {
  String title = 'Crudy APP';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context),
      
      
      home: Scaffold(
       
      
        
        body: const HomeScreen(),
           
      ),
    );
  }

  
   
}
