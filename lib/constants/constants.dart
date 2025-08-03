import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  final nunitoBold = GoogleFonts.nunito(fontSize: 43);
  final nunitoFaint = GoogleFonts.nunito(
    fontSize: 43,
    color: const Color.fromRGBO(154, 154, 154, 1),
  );
  final nunitoMed = GoogleFonts.nunito(
    fontSize: 23,
    color: const Color.fromRGBO(154, 154, 154, 1),
  );
  final nunitoNotes = GoogleFonts.nunito(
    fontSize: 23,
    color: const Color.fromARGB(255, 0, 0, 0),
  );

  List<Color> noteColors = const [
    Color.fromRGBO(255, 158, 158, 1),
    Color.fromRGBO(145, 244, 143, 1),
    Color.fromRGBO(255, 245, 153, 1),
    Color.fromRGBO(253, 153, 255, 1),
    Color.fromRGBO(158, 255, 255, 1),
    Color.fromRGBO(182, 156, 255, 1),
  ];
}
