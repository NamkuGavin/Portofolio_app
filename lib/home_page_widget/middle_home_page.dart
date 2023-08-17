import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portofolio/page/blog_page.dart';
import 'package:my_portofolio/widget/blog_item.dart';

class MiddleHomePage extends StatelessWidget {
  final FirebaseFirestore dataBlog;
  const MiddleHomePage({Key? key, required this.dataBlog}) : super(key: key);

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: dataBlog.collection("blog").limit(1).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: SpinKitRing(color: Colors.blue));
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
              color: const Color(0xFFEDF7FA),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Text(
                        "Blog posts",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.heebo(
                            fontWeight: FontWeight.w400, fontSize: 17),
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return BlogItem(data: data, index: index);
                      },
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const BlogPage(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin =
                                    Offset(-1.0, 0.0); // Slide from right
                                const end = Offset.zero;
                                const curve = Curves.easeInOut;

                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                    position: offsetAnimation, child: child);
                              },
                            ));
                      },
                      child: Row(
                        children: [
                          Text(
                            "View More",
                            style: GoogleFonts.heebo(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_rounded,
                              color: Color(0xFF21243D))
                        ],
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
