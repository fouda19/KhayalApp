import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:khayalfit/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({
    super.key,
  });

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}
class _ImageSliderState extends State<ImageSlider> {
  

@override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(child: ImageSlideshow(

          width: double.infinity,
          height: height * 0.4,

          initialPage: 0,
          indicatorRadius: 0,
          indicatorBackgroundColor: Colors.transparent,

     
          children: [
            Image.asset(
              'assets/images/1.jpeg',
              fit: BoxFit.cover,
            ),
            Image.asset(
              'assets/images/2.jpeg',
              fit: BoxFit.cover,
            ),
            Image.asset(
              'assets/images/3.jpg',
              fit: BoxFit.cover,
            ),
          ],
          disableUserScrolling: false,
     
          autoPlayInterval: 5000,

    
          isLoop: true,
        ),
        );
  }
}
