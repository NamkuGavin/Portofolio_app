import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailBlogItem extends StatelessWidget {
  final List<QueryDocumentSnapshot<Object?>> data;
  final int index;
  const DetailBlogItem({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              data[index]['title'],
              style:
                  GoogleFonts.heebo(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      data[index]['date'],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.heebo(
                          fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                  ),
                  const VerticalDivider(color: Colors.black),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        data[index]['category'],
                        style: GoogleFonts.heebo(
                            fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              data[index]['contain'],
              style:
                  GoogleFonts.heebo(fontWeight: FontWeight.w400, fontSize: 15),
            ),
          ),
          const IntrinsicHeight(child: Divider(color: Color(0xFFE0E0E0))),
        ],
      ),
    );
  }
}
