import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khayalfit/widgets/Exercisewithus.dart';
import 'package:khayalfit/widgets/dietwithus.dart';
import 'package:khayalfit/widgets/explore.dart';
import 'package:khayalfit/widgets/customeractions.dart';
import 'package:khayalfit/widgets/about.dart';
import 'package:khayalfit/widgets/package.dart';
import 'package:khayalfit/widgets/videoplayer.dart';
import 'package:video_player/video_player.dart';
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
    late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/images/welcomevideo.mp4')
      ..initialize().then((_) {
        print('video loaded');
        _controller.setLooping(true);
        _controller.setVolume(0.0);

        _controller.play();
        
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final videoWidth = _controller.value.size?.width ?? 0;
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
                      Container(
                        height: 60,
                        width: 100,
                        child: Image.asset('assets/images/Logo.jpg',
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
            Stack(children: [
            Container(
              height: height * 0.9,
              width: width,
              child: 
 Container(
                width: width,
                child: FittedBox(
                  fit: width > 650 ? BoxFit.contain : BoxFit.cover,
                  child: SizedBox(
                    width: videoWidth,
                    height: _controller.value.size?.height ?? 0,
                    child: VideoPlayer(_controller),
                  ),
                ),
              )                 
                    
              ),
            
              Positioned(
                bottom: 80,
                left: 0,
                right: 0,
                child: Container(
                  alignment: Alignment.center,
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
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      SizedBox(height: 20),
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
            SizedBox(height: 20),
            
            
          ],
        ),
      ),
    );
  }
}
