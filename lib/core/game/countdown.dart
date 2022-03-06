import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordify/utils/custom_colors.dart';

class CountdownScreen extends StatefulWidget {
  const CountdownScreen({Key? key}) : super(key: key);

  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.main_bg,
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkResponse(
                  radius: 18,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    CupertinoIcons.chevron_back,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  "Countdown",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      )),
    );
  }
}
