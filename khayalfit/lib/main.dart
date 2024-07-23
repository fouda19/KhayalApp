import 'package:flutter/material.dart';
//import 'package:khayalfit/pages/homepage.dart';
import 'package:khayalfit/pages/welcome.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print('Error loading dotenv: $e');
  }
  runApp(MyApp());
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
        primary: Color.fromARGB(255, 0, 0, 0),
        secondary: Color.fromARGB(255, 65, 12, 81), 
        tertiary: Color.fromARGB(255, 240, 236, 236),
        shadow: Color.fromARGB(255, 0, 0, 0),
        
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
