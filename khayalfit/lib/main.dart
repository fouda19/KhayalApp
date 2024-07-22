import 'package:flutter/material.dart';
import 'package:khayalfit/pages/homepage.dart';
import 'package:khayalfit/pages/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple,
        primary: Color.fromARGB(255, 247, 246, 246),
        secondary: Color.fromARGB(255, 215, 10, 10), 
        tertiary: Color.fromARGB(255, 23, 23, 23),
        shadow: Color.fromARGB(255, 212, 207, 207),
        
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

