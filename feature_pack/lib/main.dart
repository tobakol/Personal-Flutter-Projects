import 'package:feature_pack/emoji_textfield.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'search-bottom-sheet.dart';

import 'filter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Random Features'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
buildGestureDetector(context: context, featurePage: MyTextFieldWithModalBottomSheet(), title: "Search Bottom Sheet"),
              buildGestureDetector(context: context, featurePage: const EmojiPage(), title: "Emoji Page"),
                buildGestureDetector(context: context, featurePage: EmojiTextField() , title: "Emoji TextField")
              ],
            ),
          )),
    );
  }

  GestureDetector buildGestureDetector({required BuildContext context, required Widget featurePage, required String title}) {
    return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                      featurePage),
                    );
                  },
                  child: ListTile(
                    title: Text(title),
                  ));
  }
}
