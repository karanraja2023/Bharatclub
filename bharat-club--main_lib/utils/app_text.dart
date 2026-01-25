import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getTextLight({Color colors = Colors.white, size = 14.0}) {
  return GoogleFonts.exo(
    color: colors,
    fontSize: size,
    fontWeight: FontWeight.w100,
    letterSpacing: -0.2,
  );
}

TextStyle getTextRegular({
  Color colors = Colors.white,
  size = 14.0,
  heights = 1.2,
}) {
  return GoogleFonts.exo(
    color: colors,
    fontSize: size,
    fontWeight: FontWeight.normal,
    letterSpacing: -0.2,
    height: heights,
  );
}

TextStyle getTextRegularUnderline({
  Color colors = Colors.white,
  size = 14.0,
  heights = 1.2,
}) {
  return GoogleFonts.exo(
    decoration: TextDecoration.underline,
    decorationColor: colors,
    decorationThickness: 1,
    color: colors,
    fontSize: size,
    fontWeight: FontWeight.normal,
    letterSpacing: -0.2,
    height: heights,
  );
}

TextStyle getTextMedium({
  Color colors = Colors.white,
  size = 14.0,
  heights = 1.2,
  letterSpacing = -0.2,
}) {
  return GoogleFonts.exo(
    color: colors,
    fontSize: size,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.2,
    height: heights,
  );
}

TextStyle getTextMediumWithUnderLineThrough({
  Color colors = Colors.white,
  size = 14.0,
  heights = 1.2,
}) {
  return GoogleFonts.exo(
    decoration: TextDecoration.underline,
    color: colors,
    fontSize: size,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.2,
    height: heights,
  );
}

TextStyle getTextSemiBold({
  Color colors = Colors.white,
  size = 14.0,
  heights = 1.2,
}) {
  return GoogleFonts.exo(
    color: colors,
    fontSize: size,
    fontWeight: FontWeight.w600,
    wordSpacing: -0.5,
    letterSpacing: -0.2,
    height: heights,
  );
}
TextStyle getTextSemiBold1({
  Color colors = Colors.white,
  size = 14.0,
  heights = 1.2,
}) {
  return GoogleFonts.exo(
    color: colors,
    fontSize: size,
    fontWeight: FontWeight.bold,
    wordSpacing: -0.5,
    letterSpacing: -0.2,
    height: heights,
  );
}

TextStyle getTextBold({
  Color colors = Colors.white,
  size = 14.0,
  heights = 1.2,
}) {
  return GoogleFonts.exo(
    color: colors,
    fontSize: size,
    fontWeight: FontWeight.w900,
    wordSpacing: -0.5,
    letterSpacing: -0.2,
    height: heights,
  );
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String toTitleCase() => replaceAll(
    RegExp(' +'),
    ' ',
  ).split(' ').map((str) => str.toCapitalized()).join(' ');
}

getTextSpan({String word = "", size = 14.0, bool bStare = true}) {
  return RichText(
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    text: TextSpan(
      style: getTextMedium(colors: Colors.black, size: size),
      children: <TextSpan>[
        TextSpan(text: word),
        TextSpan(
          spellOut: false,
          text: bStare ? "*" : "",
          style: getTextMedium(colors: Colors.red.shade900, size: size),
        ),
      ],
    ),
  );
}
