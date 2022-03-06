import 'dart:async';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';

class WordifyDisplayToast extends StatefulWidget {
  final Widget displayWidget;
  final bool isVis;
  const WordifyDisplayToast(
      {Key? key, required this.displayWidget, required this.isVis})
      : super(key: key);

  @override
  State<WordifyDisplayToast> createState() => _WordifyDisplayToastState();
}

class _WordifyDisplayToastState extends State<WordifyDisplayToast> {
  @override
  Widget build(BuildContext context) {
    //final gameStateNotifier = ref.watch(gameStateProvider.notifier);
    //bool exitAnimation = true;

    double enabled = 1;
    double disabled = 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: OpacityAnimatedWidget.tween(
        enabled: widget.isVis,
        opacityDisabled: enabled,
        opacityEnabled: disabled,
        animationFinished: (v){

          Timer(
            const Duration(milliseconds: 1500),
              (){
                setState(() {
                  enabled = 0;
                  disabled = 1;
                });
              }
          );

        },
        curve: Curves.linear,
        child: widget.displayWidget,
      ),
    );
  }
}

class WordifySuccess extends StatelessWidget {
  final IconData displayIcon;
  final String displayMessage;
  const WordifySuccess({
    Key? key,
    required this.displayIcon,
    required this.displayMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            color: Colors.green.withOpacity(.1),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: ListTile(
          leading: Icon(
            displayIcon,
            color: Colors.green,
          ),
          title: Text(
            displayMessage,
            style: const TextStyle(color: Colors.green),
          ),
        ));
  }
}

class WordifyFail extends StatelessWidget {
  final IconData displayIcon;
  final String displayMessage;
  const WordifyFail({
    Key? key,
    required this.displayIcon,
    required this.displayMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            color: Colors.red.withOpacity(.1),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: ListTile(
          leading: Icon(
            displayIcon,
            color: Colors.red,
          ),
          title: Text(
            displayMessage,
            style: const TextStyle(color: Colors.red),
          ),
        ));
  }
}

class WordifyWarning extends StatelessWidget {
  final IconData displayIcon;
  final String displayMessage;
  const WordifyWarning({
    Key? key,
    required this.displayIcon,
    required this.displayMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            color: Colors.amber.withOpacity(.1),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: ListTile(
          leading: Icon(
            displayIcon,
            color: Colors.amber,
          ),
          title: Text(
            displayMessage,
            style: const TextStyle(color: Colors.amber),
          ),
        ));
  }
}

class WordifyInfo extends StatelessWidget {
  final IconData displayIcon;
  final String displayMessage;
  const WordifyInfo({
    Key? key,
    required this.displayIcon,
    required this.displayMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            color: Colors.blue.withOpacity(.1),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: ListTile(
          leading: Icon(
            displayIcon,
            color: Colors.blue,
          ),
          title: Text(
            displayMessage,
            style: const TextStyle(color: Colors.blue),
          ),
        ));
  }
}

class WordifyInProgress extends StatelessWidget {
  final IconData displayIcon;
  final String displayMessage;
  const WordifyInProgress({
    Key? key,
    required this.displayIcon,
    required this.displayMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.1),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: ListTile(
          leading: Icon(
            displayIcon,
            color: Colors.grey,
          ),
          title: Text(
            displayMessage,
            style: const TextStyle(color: Colors.grey),
          ),
        ));
  }
}
