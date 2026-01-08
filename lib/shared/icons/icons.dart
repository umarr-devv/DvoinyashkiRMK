import 'dart:ui';

import 'package:flutter_svg/svg.dart';

enum CustomIcons {
  home,
  search,
  favorite,
  settings;

  String get assetName => '$name.svg';

  SvgPicture call({double size = 24, Color color = const Color(0xff000000)}) {
    return SvgPicture.asset(
      'assets/svg/$assetName',
      height: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
