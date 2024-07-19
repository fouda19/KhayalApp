import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:khayalfit/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class Explore extends StatefulWidget {
  const Explore({
    super.key,
  });

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
  var width = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              Uri url = Uri.https('www.instagram.com', '/omar_khayal/');
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: Column(
              children: [
                SizedBox(height: 5),
                Align(
                  child: Column(children: [
                    Icon(
                      FontAwesomeIcons.instagram,
                      size: 30,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    SizedBox(height: 5),
                   (width>300)? Text('Follow my Instagram',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.tertiary,
                        )):Container(),
                  ]),
                ),
                SizedBox(height: 9),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () async {
              Uri url = Uri.https('www.instagram.com', '/omar_khayal/');
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: Column(
              children: [
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(children: [
                    Icon(
                      FontAwesomeIcons.tiktok,
                      size: 30,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    SizedBox(height: 5),
                  (width>300)? Text('Follow my Tiktok',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.tertiary,
                        )):Container(),
                  ]),
                ),
                SizedBox(height: 9),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
