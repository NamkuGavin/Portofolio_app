import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portofolio/widget/work_item.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/work_model.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({Key? key}) : super(key: key);

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  List<WorkModel> listWork = [
    WorkModel(
        "assets/image/app_quran.png",
        "Designing Al Qur'an App",
        "2022",
        "Application",
        "Creating a Quran app is a very worthwhile step as it can provide great benefits to its users. Here are some reasons why you might want to create a Quran app..."),
    WorkModel(
        "assets/image/app_school.png",
        "Create an application containing school materials and questions",
        "2022",
        "Application",
        "Creating an app that contains school materials and questions allows students to access school materials and questions anytime and anywhere..."),
  ];
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 30, 12),
              child: SvgPicture.asset("assets/icon/menu.svg"),
            )
          ],
        ),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25, left: 25, top: 25),
                child: Text(
                  'Work',
                  style: GoogleFonts.heebo(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 50, left: 25, right: 25),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listWork.length,
                  itemBuilder: (context, index) {
                    return WorkItem(workModel: listWork[index]);
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () => _launchUrl(context, _discord),
                              child: SvgPicture.asset("assets/icon/discord.svg")),
                          const SizedBox(width: 20),
                          InkWell(
                              onTap: () => _launchUrl(context, _instagram),
                              child: SvgPicture.asset("assets/icon/insta.svg")),
                          const SizedBox(width: 20),
                          InkWell(
                              onTap: () => _launchUrl(context, _github),
                              child: SvgPicture.asset("assets/icon/github.svg")),
                        ],
                      ),
                    ),
                    Text(
                      "Copyright ©2023 All rights reserved ",
                      style: GoogleFonts.heebo(
                          fontWeight: FontWeight.w400, fontSize: 13),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
