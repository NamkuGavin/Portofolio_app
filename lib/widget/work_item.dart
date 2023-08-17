import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portofolio/model/work_model.dart';

class WorkItem extends StatelessWidget {
  final WorkModel workModel;
  const WorkItem({Key? key, required this.workModel}) : super(key: key);

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
                    image: AssetImage(workModel.image), fit: BoxFit.cover),
                borderRadius: const BorderRadius.all(Radius.circular(12))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            workModel.title,
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
                    workModel.year,
                    style: GoogleFonts.heebo(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              ),
              Text(
                workModel.type,
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
            workModel.contain,
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
