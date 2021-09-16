import 'package:anisi_controls/anisi_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:moovebeta/utils/strings/app_strings.dart';
import 'package:share/share.dart';

import '../../../data/app_database.dart';
import '../../../data/models/word.dart';

/// Show a full View of a word meaning
class WordView extends StatelessWidget {
  final Word word;

  WordView(this.word);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(true);
        return true;
      },
      child: Scaffold(),
    );
  }

}
