import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 30, 0),
              child: SvgPicture.asset("assets/icon/menu.svg"),
            )
          ],
        ),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
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
                              image: AssetImage('assets/image/profile_pic.jpg'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(Radius.circular(200)),
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
                        "Hai, saya Muhammad Gavin Arasyi, Flutter Android Developer",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.heebo(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Text(
                        "Saya menggunakan flutter selama 3 tahun lebih karena Dart, bahasa pemrograman yang digunakan dalam Flutter, telah dirancang untuk mengoptimalkan kinerja aplikasi. Flutter mengompilasi kode Anda langsung ke kode mesin (native), yang menghasilkan kinerja aplikasi yang responsif dan cepat",
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
            )
          ],
        ),
      ),
    );
  }
}
