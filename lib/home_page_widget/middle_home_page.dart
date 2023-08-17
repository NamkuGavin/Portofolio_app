import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
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
        stream: dataBlog.collection("blog").snapshots(),
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
                        "Recent posts",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.heebo(
                            fontWeight: FontWeight.w400, fontSize: 17),
                      ),
                    ),
                    ListView.builder(
                      reverse: true,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return BlogItem(data: data, index: index);
                      },
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
