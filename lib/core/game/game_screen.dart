import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordify/utils/custom_colors.dart';
import 'package:wordify/widgets/wordify_grid.dart';
import 'package:wordify/widgets/wordify_header.dart';
import 'package:wordify/widgets/wordify_keyboard.dart';
import 'package:wordify/widgets/wordify_toasts.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.main_bg,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.only(top: 10),
        child: const GameScreenBody(),
      )),
    );
  }
}

class GameScreenBody extends ConsumerWidget {
  const GameScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final gameState = ref.watch(gameStateProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: const [
        WordifyHeader(),
        WordifyGrid(),
        Wordifykeyboard()
      ],
    );
  }
}
