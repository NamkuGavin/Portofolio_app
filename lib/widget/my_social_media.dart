import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaLink extends StatelessWidget {
  const SocialMediaLink({Key? key}) : super(key: key);
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

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    child: SvgPicture.asset("assets/icon/discord.svg")),
                const SizedBox(width: 20),
                InkWell(
                    onTap: () => _launchUrl(context, _instagram),
                    child: SvgPicture.asset("assets/icon/insta.svg")),
                const SizedBox(width: 20),
                InkWell(
                    onTap: () => _launchUrl(context, _github),
                    child: SvgPicture.asset("assets/icon/github.svg")),
              ],
            ),
          ),
          Text(
            "Copyright ©2023 All rights reserved ",
            style: GoogleFonts.heebo(fontWeight: FontWeight.w400, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
