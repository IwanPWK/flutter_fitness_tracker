import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Map<String, String> dropDownMenu = {
  'weight': 'Weight',
  'set': 'Set',
  'repetition': 'Repetition',
};

const Map<String, String> tabMenu = {
  'all': 'All',
  'set': 'Set',
  'repetition': 'Repetition',
};

TextStyle textStyle(
  double size,
  Color color,
  FontWeight fw, {
  int fontType = 5,
}) {
  if (fontType == 1) {
    return GoogleFonts.roboto(
      fontSize: size,
      color: color,
      fontWeight: fw,
    );
  } else if (fontType == 2) {
    return GoogleFonts.openSans(
      fontSize: size,
      color: color,
      fontWeight: fw,
    );
  } else if (fontType == 3) {
    return GoogleFonts.lato(
      fontSize: size,
      color: color,
      fontWeight: fw,
    );
  } else if (fontType == 4) {
    return GoogleFonts.oswald(
      fontSize: size,
      color: color,
      fontWeight: fw,
    );
  } else {
    return GoogleFonts.raleway(
      fontSize: size,
      color: color,
      fontWeight: fw,
    );
  }
}
