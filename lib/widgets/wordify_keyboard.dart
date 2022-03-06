import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordify/widgets/wordify_key.dart';

class Wordifykeyboard extends StatefulWidget {
  const Wordifykeyboard({Key? key}) : super(key: key);

  @override
  _WordifykeyboardState createState() => _WordifykeyboardState();
}

class _WordifykeyboardState extends State<Wordifykeyboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [for (var key in "qwertyuiop".split("")) WordifyKey(key)],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [for (var key in "asdfghjkl".split("")) WordifyKey(key)],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var key in "<zxcvbnm_".split("")) WordifyKey(key),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
