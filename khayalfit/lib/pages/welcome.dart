import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khayalfit/widgets/Exercisewithus.dart';
import 'package:khayalfit/widgets/dietwithus.dart';
import 'package:khayalfit/widgets/explore.dart';
import 'package:khayalfit/widgets/customeractions.dart';
import 'package:khayalfit/widgets/about.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage>   with TickerProviderStateMixin {
  //di 3ashan el sora tegy men fo2
  late final AnimationController imagecontroller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<Offset> offsetimageAnimation = Tween<Offset>(
    end: Offset.zero,
    begin: const Offset(0, -2),
  ).animate(CurvedAnimation(
    parent: imagecontroller,
    curve: Curves.easeInOutBack
  ));
  //logoo
    late final Animation<Offset> offsetlogoAnimation = Tween<Offset>(
    end: Offset.zero,
    begin: const Offset(0, -2),
  ).animate(CurvedAnimation(
    parent: imagecontroller,
    curve: Curves.easeInOutBack
  ));
  //di 3ashan el zarayer

  late final Animation<Offset> offsetbuttoncontroller = Tween<Offset>(
    end: Offset.zero,
    begin: const Offset(10, 0),
  ).animate(CurvedAnimation(
    parent: imagecontroller,
    curve: Curves.easeInOut,
  ));
// dol lel text

  late final Animation<Offset> offsettextcontroller = Tween<Offset>(
    end: Offset.zero,
    begin: const Offset(-10, 0),
  ).animate(CurvedAnimation(
    parent: imagecontroller,
    curve: Curves.easeInOut,
  ));

  void initState() {
    super.initState();
 
        
    imagecontroller.forward();

  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Container(
        decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 34, 34, 34), Color.fromARGB(255, 57, 56, 56)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  height: height * 0.1,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: SlideTransition(
                      position: offsetlogoAnimation,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 60,
                            width: 100,
                            child: Image.asset('assets/images/Logo.png',
                                fit: BoxFit.contain
                              
                            ),
                          ),
                          
                                        Text(
                            'Khayalergy',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.doHyeon(
                              fontSize: 30,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Stack(children: [
              SlideTransition(
                position: offsetimageAnimation,
                  child: Container(
                    height: height * 0.9,
                    width: width,
                    child: Image.asset(
                      'assets/images/khayal1.jpg',
                      fit:(width>600)? BoxFit.contain:BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 80,
                  left: 0,
                  right: 0,
                  
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SlideTransition(
                            position: offsettextcontroller,
                            child: Column(
                              children: [
                                Text(
                                  'Unleash your potential',
                                  style: GoogleFonts.pacifico(
                                    fontSize: 28,
                                    color: Theme.of(context).colorScheme.tertiary,
                                  ),
                                ),
                              
                                                  
                            SizedBox(height: 10),
                            Text(
                              'Join Khayalergy now',
                              style: GoogleFonts.aBeeZee(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                              ],),
                          ),
                          SizedBox(height: 20),
                          SlideTransition(
                            position: offsetbuttoncontroller,
                            child: CustomerActions()),
                        ],
                      ),
                    ),
                  ),
              
              ]),
      
              ExerciseWithUs(),
              DietWithUs(),
              Explore(),
              About(),
        
              
              
            ],
          ),
        ),
      ),
    );
  }
}
