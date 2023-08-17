import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class BelowHomePage extends StatelessWidget {
  const BelowHomePage({Key? key}) : super(key: key);

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

  bool _isValidUrl(String url) {
    Uri? uri = Uri.tryParse(url);
    return uri != null && uri.isAbsolute;
  }

  @override
  Widget build(BuildContext context) {
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
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        height: 250,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/image/app_quran.png"),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Designing Al Qur'an App",
                        style: GoogleFonts.heebo(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 3),
                              decoration: const BoxDecoration(
                                color: Color(0xFF142850),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                              child: Text(
                                "2022",
                                style: GoogleFonts.heebo(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                          Text(
                            "Application",
                            style: GoogleFonts.heebo(
                                color: const Color(0xFF8695A4),
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        "Creating a Quran app is a very worthwhile step as it can provide great benefits to its users. Here are some reasons why you might want to create a Quran app...",
                        style: GoogleFonts.heebo(
                            fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 100),
                      child: IntrinsicHeight(
                          child: Divider(color: Color(0xFFE0E0E0))),
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
                                  onTap: () => _launchUrl(context, _discord),
                                  child: SvgPicture.asset(
                                      "assets/icon/discord.svg")),
                              const SizedBox(width: 20),
                              InkWell(
                                  onTap: () => _launchUrl(context, _instagram),
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
