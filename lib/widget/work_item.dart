import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portofolio/model/work_model.dart';

class WorkItem extends StatelessWidget {
  final List<QueryDocumentSnapshot<Object?>> data;
  final int index;
  const WorkItem({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            height: 250,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(data[index]['image']),
                    fit: BoxFit.cover),
                borderRadius: const BorderRadius.all(Radius.circular(12))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            data[index]['title'],
            style: GoogleFonts.heebo(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  decoration: const BoxDecoration(
                    color: Color(0xFF142850),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Text(
                    data[index]['year'],
                    style: GoogleFonts.heebo(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              ),
              Text(
                data[index]['type'],
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
            data[index]['contain'],
            style: GoogleFonts.heebo(fontWeight: FontWeight.w400, fontSize: 15),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: IntrinsicHeight(child: Divider(color: Color(0xFFE0E0E0))),
        ),
      ],
    );
  }
}
