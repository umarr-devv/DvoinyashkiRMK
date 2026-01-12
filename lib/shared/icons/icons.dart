// ignore_for_file: constant_identifier_names

import 'dart:ui';

import 'package:flutter_svg/svg.dart';

enum CustomIcons {
  som,
  logo,
  icon,
  invert_icon;

  String get assetName => '$name.svg';

  SvgPicture call({double size = 24, Color? color}) {
    return SvgPicture.asset(
      'assets/svg/$assetName',
      height: size,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
    );
  }
}
