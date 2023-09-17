import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portofolio/widget/my_social_media.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailWorkPage extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> detailData;
  const DetailWorkPage({Key? key, required this.detailData}) : super(key: key);

  @override
  State<DetailWorkPage> createState() => _DetailWorkPageState();
}

class _DetailWorkPageState extends State<DetailWorkPage>
    with TickerProviderStateMixin {
  late TransformationController controller1;
  late TransformationController controller2;
  TapDownDetails? tapDownDetails;
  late AnimationController animationController1;
  late AnimationController animationController2;
  Animation<Matrix4>? animation;

  @override
  void initState() {
    super.initState();
    controller1 = TransformationController();
    controller2 = TransformationController();
    animationController1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        controller1.value = animation!.value;
      });
    animationController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        controller2.value = animation!.value;
      });
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    animationController1.dispose();
    animationController2.dispose();
    super.dispose();
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
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      widget.detailData['detail_work']['title'],
                      style: GoogleFonts.heebo(
                          fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 3),
                            decoration: const BoxDecoration(
                              color: Color(0xFF142850),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            child: Text(
                              widget.detailData['detail_work']['year'],
                              style: GoogleFonts.heebo(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        Text(
                          widget.detailData['detail_work']['type'],
                          style: GoogleFonts.heebo(
                              color: const Color(0xFF8695A4),
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      widget.detailData['detail_work']['text'],
                      style: GoogleFonts.heebo(
                          fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget
                                  .detailData['detail_work']['image_app']),
                              fit: BoxFit.cover),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                    ),
                  ),
                ],
              ),
            )),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      widget.detailData['detail_work']['feature']['title'],
                      style: GoogleFonts.heebo(
                          fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      widget.detailData['detail_work']['feature']
                          ['first_feature']['title'],
                      style: GoogleFonts.heebo(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      widget.detailData['detail_work']['feature']
                          ['first_feature']['desc'],
                      style: GoogleFonts.heebo(
                          fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Column(
                      children: [
                        GestureDetector(
                          onDoubleTapDown: (details) =>
                              tapDownDetails = details,
                          onDoubleTap: () {
                            final position = tapDownDetails!.localPosition;

                            const double scale = 3;
                            final x = -position.dx * (scale - 1);
                            final y = -position.dy * (scale - 1);
                            final zoomed = Matrix4.identity()
                              ..translate(x, y)
                              ..scale(scale);

                            final end = controller1.value.isIdentity()
                                ? zoomed
                                : Matrix4.identity();

                            animation =
                                Matrix4Tween(begin: controller1.value, end: end)
                                    .animate(CurveTween(curve: Curves.easeOut)
                                        .animate(animationController1));

                            animationController1.forward(from: 0);
                          },
                          child: InteractiveViewer(
                            transformationController: controller1,
                            panEnabled: false,
                            scaleEnabled: false,
                            child: Container(
                              height: 175,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                    widget.detailData['detail_work']['feature']
                                        ['first_feature']['img_code'],
                                  )),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8))),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onDoubleTapDown: (details) =>
                              tapDownDetails = details,
                          onDoubleTap: () {
                            final position = tapDownDetails!.localPosition;

                            const double scale = 3;
                            final x = -position.dx * (scale - 1);
                            final y = -position.dy * (scale - 1);
                            final zoomed = Matrix4.identity()
                              ..translate(x, y)
                              ..scale(scale);

                            final end = controller2.value.isIdentity()
                                ? zoomed
                                : Matrix4.identity();

                            animation =
                                Matrix4Tween(begin: controller2.value, end: end)
                                    .animate(CurveTween(curve: Curves.easeOut)
                                        .animate(animationController2));

                            animationController2.forward(from: 0);
                          },
                          child: InteractiveViewer(
                            transformationController: controller2,
                            panEnabled: false,
                            scaleEnabled: false,
                            child: Container(
                              height: 175,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                    widget.detailData['detail_work']['feature']
                                        ['first_feature']['img_code2'],
                                  )),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8))),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 250,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    widget.detailData['detail_work']['feature']
                                        ['first_feature']['img_ui'],
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
            const SliverToBoxAdapter(child: SocialMediaLink()),
          ],
        ),
      ),
    );
  }
}
