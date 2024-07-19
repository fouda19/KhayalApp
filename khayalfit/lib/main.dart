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
        primary: Color.fromARGB(255, 23, 23, 23),
        secondary: Color.fromARGB(255, 41, 9, 71), 
        tertiary: Color.fromARGB(255, 245, 245, 245),
        
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

