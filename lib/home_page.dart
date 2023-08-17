import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore dataBlog = FirebaseFirestore.instance;

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
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 50),
                        child: Container(
                          height: 140,
                          width: 140,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/image/profile_pic.jpg'),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(200)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFEDF7FA),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(-8, 4), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Text(
                          "Hi, I'm Muhammad Gavin Arasyi, Flutter Android Developer.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.heebo(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: Text(
                          "I've been using Flutter for over 3 years because Dart, the programming language used in Flutter, has been designed to optimize app performance. Flutter compiles your code directly to machine code (native), which results in responsive and fast app performance.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.heebo(
                              fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          backgroundColor: const Color(0xFFFF6464),
                          fixedSize: const Size.fromWidth(200),
                          padding: const EdgeInsets.all(12),
                        ),
                        child: Text(
                          "Download Resume",
                          style: GoogleFonts.heebo(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: StreamBuilder<QuerySnapshot>(
                  stream: dataBlog.collection("portofolio").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!.docs;
                      return Container(
                        color: const Color(0xFFEDF7FA),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 25),
                                child: Text(
                                  "Recent posts",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.heebo(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 25),
                                    child: Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Text(
                                              data[index]['title'],
                                              style: GoogleFonts.heebo(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20),
                                            child: IntrinsicHeight(
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 20),
                                                    child: Text(
                                                      "12 Feb 2020",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.heebo(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  const VerticalDivider(
                                                      color: Colors.black),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20),
                                                    child: Text(
                                                      "Design, Pattern",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.heebo(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
                                            style: GoogleFonts.heebo(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (snapshot.connectionState ==
                            ConnectionState.active &&
                        snapshot.hasError) {
                      _onWidgetDidBuild(() {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('${snapshot.error}'),
                          backgroundColor: Colors.red,
                        ));
                      });
                    }
                    return const SpinKitRing(color: Colors.blue);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
