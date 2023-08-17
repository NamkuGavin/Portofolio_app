import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portofolio/widget/blog_item.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/detail_blog_item.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  FirebaseFirestore dataBlog = FirebaseFirestore.instance;
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

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
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
                  'Blog',
                  style: GoogleFonts.heebo(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: StreamBuilder<QuerySnapshot>(
                  stream: dataBlog.collection("blog").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: SpinKitRing(color: Colors.blue));
                    } else if (snapshot.connectionState ==
                            ConnectionState.active &&
                        snapshot.hasError) {
                      _onWidgetDidBuild(() {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('${snapshot.error}'),
                          backgroundColor: Colors.red,
                        ));
                      });
                    } else {
                      final data = snapshot.data!.docs;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 20),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return DetailBlogItem(data: data, index: index);
                          },
                        ),
                      );
                    }
                    return Container();
                  }),
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
                              child:
                                  SvgPicture.asset("assets/icon/discord.svg")),
                          const SizedBox(width: 20),
                          InkWell(
                              onTap: () => _launchUrl(context, _instagram),
                              child: SvgPicture.asset("assets/icon/insta.svg")),
                          const SizedBox(width: 20),
                          InkWell(
                              onTap: () => _launchUrl(context, _github),
                              child:
                                  SvgPicture.asset("assets/icon/github.svg")),
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
