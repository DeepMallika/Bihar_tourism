import 'package:flutter/material.dart';
import 'package:lstrv_app/pages/attraction/attract.dart';
import 'package:lstrv_app/pages/attraction/attract_details_page.dart';
import 'package:lstrv_app/utils/style.dart';
import 'package:palette_generator/palette_generator.dart';

import 'clipped_image.dart';
import 'name_widget.dart';

class MemberWidget extends StatelessWidget {
  final Member member;
  final bool compactMode;

  MemberWidget({this.member, this.compactMode = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _generatePalette(context, member.imagePath).then((_palette) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MemberDetailsPage(member: member, palette: _palette)));
        });
      },
      child: Row(
        children: <Widget>[
          ClippedImage(imagePath: member.imagePath, compactMode: compactMode),
          SizedBox(width:30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              NameWidget(name: member.name, style: nameStyle),
              SizedBox(height: 14),
            ],
          )
        ],
      ),
    );
  }

  Future<PaletteGenerator> _generatePalette(context, String imagePath) async {
    PaletteGenerator _paletteGenerator = await PaletteGenerator.fromImageProvider(AssetImage(imagePath),
        size: Size(150, 150), maximumColorCount: 20);

    return _paletteGenerator;
  }
}