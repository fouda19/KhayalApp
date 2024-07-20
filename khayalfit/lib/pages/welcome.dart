import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khayalfit/widgets/Exercisewithus.dart';
import 'package:khayalfit/widgets/dietwithus.dart';
import 'package:khayalfit/widgets/explore.dart';
import 'package:khayalfit/widgets/customeractions.dart';
import 'package:khayalfit/widgets/about.dart';
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                height: height * 0.1,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.sports_gymnastics_outlined,
                          size: 20,
                          color: Theme.of(context).colorScheme.tertiary),
                      Text(
                        'Khayalergy',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.abrilFatface(
                          fontSize: 25,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Stack(children: [
              Container(
                height: height * 0.9,
                width: width,
                child: Image.asset(
                  'assets/images/gif.gif',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        'Khayalergy',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      CustomerActions(),
                    ],
                  ),
                ),
              ),
            ]),
            SizedBox(height: 40),
             ExerciseWithUs(),
            SizedBox(height: 40),
            DietWithUs(),
            SizedBox(height: 20),
            Explore(),
            SizedBox(height: 20),
            About(),
            
          ],
        ),
      ),
    );
  }
}
