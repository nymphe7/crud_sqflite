

import 'package:crudy/screen/crudbdy.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height/2;
    double width = MediaQuery.of(context).size.width/4;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Image(
            fit: BoxFit.cover,
            image: AssetImage(
              'anz.jpeg',
            ),
          ),
          Positioned(
            right: width,
            bottom: height,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return const CrudBdy();
                }));
              },
              child: RichText
              (text: const TextSpan(
                children: [
                  TextSpan(text: 'Tap\n',
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 80,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic
                  ),),
                  TextSpan(text: 'Me',
                  style: TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 80,
                    fontWeight: FontWeight.bold
                  ),),
                  TextSpan(text: '!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 80,
                    fontWeight: FontWeight.bold
                  ),),


                ]
                  
                
              ))
            ),
          ),
        ],
      ),
    );
  }
}
