import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class UpperHomePage extends StatelessWidget {
  final FirebaseFirestore dataBlog;
  const UpperHomePage({Key? key, required this.dataBlog}) : super(key: key);

  final String _url = 'https://github.com/NamkuGavin/Portofolio_app';

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  Future<void> _launchUrl(BuildContext context) async {
    if (_isValidUrl(_url)) {
      if (!await launchUrl(Uri.parse(_url))) {
        throw Exception('Could not launch $_url');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid URL: $_url'),
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
    return StreamBuilder<DocumentSnapshot>(
        stream: dataBlog.collection("about").doc('about me').snapshots(),
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
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Container(
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
                        '${data['name']}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.heebo(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Text(
                        '${data['contain']}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.heebo(
                            fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _launchUrl(context),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        backgroundColor: const Color(0xFFFF6464),
                        fixedSize: const Size.fromWidth(250),
                        padding: const EdgeInsets.all(12),
                      ),
                      child: Text(
                        "View the source code",
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
            );
          }
          return Container();
        });
  }
}
