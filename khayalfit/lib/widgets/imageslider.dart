import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:khayalfit/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ImageSlider extends StatefulWidget {
  final List<String> images ;
  const ImageSlider({
    super.key,
    required this.images,

  });

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}
class _ImageSliderState extends State<ImageSlider> {
  

@override
  Widget build(BuildContext context) {
    List<Widget> imageWidgets = widget.images.map((path) {
  return Image.asset(
    path,
    fit: BoxFit.contain,
  );
}).toList();

    var height = MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    return Container(child: ImageSlideshow(

          width: double.infinity,
          height:(width>600)? height*0.8:height * 0.6,
        

          initialPage: 0,
          indicatorRadius: 0,
          indicatorBackgroundColor: Colors.transparent,

     
          children: imageWidgets,
          disableUserScrolling: false,
     
          autoPlayInterval: 7000,

    
          isLoop: true,
        ),
        );
  }
}
