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
  runApp(const MyApp());
}

class MyColors extends ThemeExtension<MyColors> {
  final Color gradientStart;
  final Color gradientEnd;

  const MyColors({required this.gradientStart, required this.gradientEnd});

  @override
  MyColors copyWith({Color? gradientStart, Color? gradientEnd}) {
    return MyColors(
      gradientStart: gradientStart ?? this.gradientStart,
      gradientEnd: gradientEnd ?? this.gradientEnd,
    );
  }

  @override
  MyColors lerp(ThemeExtension<MyColors>? other, double t) {
    if (other is! MyColors) {
      return this;
    }
    return MyColors(
      gradientStart: Color.lerp(gradientStart, other.gradientStart, t)!,
      gradientEnd: Color.lerp(gradientEnd, other.gradientEnd, t)!,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KHAYALERGY',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 183, 139, 58),
        primary: Color.fromARGB(255, 0, 0, 0),//Color.fromARGB(255, 57, 56, 56), grey
        secondary: Color.fromARGB(255, 229, 101, 52), 
        tertiary: const Color.fromARGB(255, 255, 255, 255),
        shadow: const Color.fromARGB(255, 0, 0, 0),
        
        ),
        useMaterial3: true,
        extensions: const [
          MyColors(
            gradientStart: Color.fromARGB(255, 177, 13, 7),
            gradientEnd: Color.fromARGB(255, 226, 59, 8),
          ),
        ],
      ),
      home: const HomePage(),
    );
  }
}