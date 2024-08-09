import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khayalfit/widgets/contactus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';



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
    return  Container(
      decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 34, 34, 34), Color.fromARGB(255, 57, 56, 56)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
      child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'SOCIAL MEDIA PLATFORMS',
                  style: GoogleFonts.abrilFatface
                (
                    fontSize: (width>600)? 40:25,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
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
                         (width>300)? Text('Omar_khayal',
                              style: GoogleFonts.pacifico(
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
                  width: 30,
                ),
                InkWell(
                  onTap: () async {
                    Uri url = Uri.https('www.tiktok.com', '/@khayalergy');
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
                        (width>300)? Text('Khayalergy',
                              style: GoogleFonts.pacifico(
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
            SizedBox(height: 20),
            ContactUs(),
          ],
        ),
    );
    
  }
}
