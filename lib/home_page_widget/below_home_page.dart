import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portofolio/page/work_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/work_item.dart';

class BelowHomePage extends StatelessWidget {
  final FirebaseFirestore dataBlog;
  const BelowHomePage({Key? key, required this.dataBlog}) : super(key: key);

  final String _discord = 'https://discordapp.com/users/593593353463922688';
  final String _instagram =
      'https://instagram.com/gavinarasyi?igshid=MzRlODBiNWFlZA==';
  final String _github = 'https://github.com/NamkuGavin';

  Future<void> _launchUrl(BuildContext context, String url) async {
    if (_isValidUrl(url)) {
      if (!await launchUrl(Uri.parse(url))) {
        throw Exception('Could not launch $url');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid URL: $url'),
        ),
      );
    }
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  bool _isValidUrl(String url) {
    Uri? uri = Uri.tryParse(url);
    return uri != null && uri.isAbsolute;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: dataBlog.collection("featured_work").limit(1).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else if (snapshot.connectionState == ConnectionState.active &&
              snapshot.hasError) {
            _onWidgetDidBuild(() {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('${snapshot.error}'),
                backgroundColor: Colors.red,
              ));
            });
          } else {
            final data = snapshot.data!.docs;
            return Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Text(
                        "Featured works",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.heebo(
                            fontWeight: FontWeight.w400, fontSize: 17),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return WorkItem(data: data, index: index);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 100),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const WorkPage(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin =
                                          Offset(-1.0, 0.0); // Slide from right
                                      const end = Offset.zero;
                                      const curve = Curves.easeInOut;

                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      var offsetAnimation =
                                          animation.drive(tween);

                                      return SlideTransition(
                                          position: offsetAnimation,
                                          child: child);
                                    },
                                  ));
                            },
                            child: Row(
                              children: [
                                Text(
                                  "View More",
                                  style: GoogleFonts.heebo(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_forward_rounded,
                                    color: Color(0xFF21243D))
                              ],
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: () =>
                                          _launchUrl(context, _discord),
                                      child: SvgPicture.asset(
                                          "assets/icon/discord.svg")),
                                  const SizedBox(width: 20),
                                  InkWell(
                                      onTap: () =>
                                          _launchUrl(context, _instagram),
                                      child: SvgPicture.asset(
                                          "assets/icon/insta.svg")),
                                  const SizedBox(width: 20),
                                  InkWell(
                                      onTap: () => _launchUrl(context, _github),
                                      child: SvgPicture.asset(
                                          "assets/icon/github.svg")),
                                ],
                              ),
                            ),
                            Text(
                              "Copyright ©2023 All rights reserved ",
                              style: GoogleFonts.heebo(
                                  fontWeight: FontWeight.w400, fontSize: 13),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        });
  }
}
