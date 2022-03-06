//import 'dart:io';

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordify/core/other/feedback.dart';
import 'package:wordify/providers/settings_provider.dart';
import 'package:wordify/utils/custom_colors.dart';
import 'package:wordify/widgets/wordify_toasts.dart';

import 'settings_lang.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> updateNotificationsSettings(bool isN) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('settings_notifications_active', isN);
  }

  Future<void> updateVibrationsSettings(bool isV) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('settings_vibrations_active', isV);
  }

  Future<bool> fetchNotificationsPrefs() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool('settings_notifications_active')!;
  }

  Future<bool> fetchVibrationsPrefs() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool('settings_vibrations_active')!;
  }

  triggerShareBottomsheet(){
    showModalBottomSheet(
        backgroundColor: CustomColors.main_bg,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            )),
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                trailing: InkResponse(
                  radius: 16,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    CupertinoIcons.xmark,
                    color: Colors.redAccent,
                    size: 16,
                  ),
                ),
                title: const Text(
                  'Share Wordify',
                  style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    ListTile(
                      onTap: (){},
                      leading: const Icon(Icons.facebook_rounded, color: Colors.blueAccent,),
                      title: const Text(
                        'Share as Facebook post',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                      ),
                      trailing: const Icon(CupertinoIcons.chevron_forward, color: Colors.amber, size: 18,),
                    ),
                    ListTile(
                      onTap: (){},
                      leading: const Icon(Icons.facebook_rounded, color: Colors.blueAccent,),
                      title: const Text(
                        'Share as Facebook story',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                      ),
                      trailing: const Icon(CupertinoIcons.chevron_forward, color: Colors.amber, size: 18,),
                    ),
                    ListTile(
                      onTap: (){},
                      leading: const Icon(Icons.mail_rounded, color: Colors.amber,),
                      title: const Text(
                        'Share as a message',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                      ),
                      trailing: const Icon(CupertinoIcons.chevron_forward, color: Colors.amber, size: 18,),
                    ),
                    ListTile(
                      onTap: (){},
                      leading: const Icon(Icons.whatsapp_rounded, color: Colors.greenAccent,),
                      title: const Text(
                        'Share to a WhatsApp contact',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                      ),
                      trailing: const Icon(CupertinoIcons.chevron_forward, color: Colors.amber, size: 18,),
                    ),
                    ListTile(
                      onTap: (){},
                      leading: const Icon(Icons.telegram_rounded, color: Colors.lightBlueAccent,),
                      title: const Text(
                        'Share to Telegram',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                      ),
                      trailing: const Icon(CupertinoIcons.chevron_forward, color: Colors.amber, size: 18,),
                    ),
                    ListTile(
                      onTap: (){},
                      leading: const Icon(Icons.outgoing_mail, color: Colors.redAccent,),
                      title: const Text(
                        'Share as an Email',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                      ),
                      trailing: const Icon(CupertinoIcons.chevron_forward, color: Colors.amber, size: 18,),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.main_bg,
      body: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 10,),
            child: SingleChildScrollView(
              child: Column(
                children: [
                Container(
                  margin: const EdgeInsets.only(top: 10,left: 16,),
                child: Row(
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
                      "Settings",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              /* DIFFICULTY OPTIONS ----*/
              /*
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(.2),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: const ListTile(
                  enabled: false,
                  leading: Icon(
                    CupertinoIcons.exclamationmark_triangle,
                    color: Colors.red,
                  ),
                  title: Text(
                    "Changing difficulties mid-game will make you lose progress and game will be restarted.",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              const DifficultyToggle(),
              const SizedBox(
                height: 32,
              ),
              */
              /* SETTINGS OPTIONS ----*/
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const SettingsLang()));
                },
                title: Row(
                  children: const [
                    Text(
                      "Change languages",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Icon(
                      CupertinoIcons.chevron_forward,
                      color: Colors.amber,
                    )
                  ],
                ),
              ),
              FutureBuilder<bool>(
                  future: fetchNotificationsPrefs(),
                  builder: (context, snapshot) {
                    return ListTile(
                      title: const Text(
                        "Notifications",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text(
                        "Reminders, challenges and other push.",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                      ),
                      trailing: CupertinoSwitch(
                          //trackColor: Colors.redAccent.shade100,
                          value: snapshot.data ?? true,
                          onChanged: (value) {
                            setState(() {
                              updateNotificationsSettings(value);
                            });
                          }),
                    );
                  }),
              FutureBuilder<bool>(
                  future: fetchVibrationsPrefs(),
                  builder: (context, snapshot) {
                    return ListTile(
                        title: const Text(
                          "Vibrations",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text(
                          "Enable or Disable game vibrations.",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 12),
                        ),
                        trailing: CupertinoSwitch(
                            value: snapshot.data ?? true,
                            onChanged: (value) {
                              setState(() {
                                updateVibrationsSettings(value);
                              });
                            }));
                  }),
              ListTile(
                onTap: () {},
                title: const Text(
                  "Check for updates",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const FeedbackScreen(),
                          fullscreenDialog: true));
                },
                title: const Text(
                  "Feedback",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  "Send suggestions on how to improve or report bugs.",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 12),
                ),
              ),
              ListTile(
                onTap: () {},
                title: const Text(
                  "Rate us",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  Platform.isIOS
                      ? "Rate us on App store."
                      : Platform.isAndroid
                          ? "Rate us on Play store."
                          : "Rate us on the store.",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 12),
                ),
              ),
              ListTile(
                onTap: () {
                  triggerShareBottomsheet();
                },
                title: const Text(
                  "Share",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  "Sharing is caring! Share Wordify with friends.",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 12),
                ),
              ),
              ListTile(
                title: const Text(
                  "Version 0.1.0",
                  style: TextStyle(
                    color: Colors.white60,
                  ),
                ),
                subtitle: Text(
                  "CLOSED BETA | Build number ${DateTime.now().millisecondsSinceEpoch} - HIVEMIND IO",
                  style: const TextStyle(
                      color: Colors.white60,
                      fontWeight: FontWeight.w300,
                      fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class DifficultyToggle extends ConsumerWidget {
  const DifficultyToggle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameSettings = ref.watch(gameSettingsProvider);
    final gameSettingsNotifier = ref.read(gameSettingsProvider.notifier);

    void _updateAttemptsInc() {
      var newAttemptsNbr = 5;
      if (gameSettings.attemptsPerGame == 4) newAttemptsNbr = 5;
      if (gameSettings.attemptsPerGame == 5) newAttemptsNbr = 6;
      if (gameSettings.attemptsPerGame == 6) newAttemptsNbr = 4;

      gameSettingsNotifier.updateAttempts(newAttemptsNbr);
    }

    void _updateAttemptsDec() {
      var newAttemptsNbr = 5;
      if (gameSettings.attemptsPerGame == 4) newAttemptsNbr = 6;
      if (gameSettings.attemptsPerGame == 5) newAttemptsNbr = 4;
      if (gameSettings.attemptsPerGame == 6) newAttemptsNbr = 5;

      gameSettingsNotifier.updateAttempts(newAttemptsNbr);
    }

    void _updateWordInc() {
      var newWordSize = 5;
      if (gameSettings.wordSize == 4) newWordSize = 5;
      if (gameSettings.wordSize == 5) newWordSize = 6;
      if (gameSettings.wordSize == 6) newWordSize = 4;

      gameSettingsNotifier.updateWordSize(newWordSize);
    }

    void _updateWordDec() {
      var newWordSize = 5;
      if (gameSettings.wordSize == 4) newWordSize = 6;
      if (gameSettings.wordSize == 5) newWordSize = 4;
      if (gameSettings.wordSize == 6) newWordSize = 5;

      gameSettingsNotifier.updateWordSize(newWordSize);
    }

    return Column(
      children: [
        Column(
          children: [
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Word difficulty",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    gameSettings.wordSize == 4
                        ? "EASY"
                        : gameSettings.wordSize == 5
                            ? "STANDARD"
                            : "DIFFICULT",
                    style: const TextStyle(
                        color: Colors.amber, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              subtitle: Text(
                "${gameSettings.wordSize} Letters",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w300),
              ),
            ),
            Row(
              children: [
                IconButton(
                    splashRadius: 18,
                    onPressed: () {
                      _updateWordDec();
                    },
                    icon: const Icon(
                      CupertinoIcons.chevron_back,
                      color: Colors.white,
                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: 6,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(42)),
                        color: Colors.greenAccent),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: 6,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(42)),
                        color: gameSettings.wordSize < 5
                            ? Colors.grey
                            : Colors.deepOrangeAccent),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(42)),
                        color: gameSettings.wordSize < 6
                            ? Colors.grey
                            : Colors.red),
                  ),
                ),
                IconButton(
                    splashRadius: 18,
                    onPressed: () {
                      _updateWordInc();
                    },
                    icon: const Icon(
                      CupertinoIcons.chevron_forward,
                      color: Colors.white,
                    )),
              ],
            ),
          ],
        ),
        Column(
          children: [
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Attempts difficulty",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    gameSettings.attemptsPerGame == 6
                        ? "EASY"
                        : gameSettings.attemptsPerGame == 5
                            ? "STANDARD"
                            : "DIFFICULT",
                    style: const TextStyle(
                        color: Colors.amber, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              subtitle: Text(
                "${gameSettings.attemptsPerGame} Attempts",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w300),
              ),
            ),
            Row(
              children: [
                IconButton(
                    splashRadius: 18,
                    onPressed: () {
                      _updateAttemptsDec();
                    },
                    icon: const Icon(
                      CupertinoIcons.chevron_back,
                      color: Colors.white,
                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: 6,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(42)),
                        color: Colors.red),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: 6,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(42)),
                        color: gameSettings.attemptsPerGame < 5
                            ? Colors.grey
                            : Colors.deepOrangeAccent),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(42)),
                        color: gameSettings.attemptsPerGame < 6
                            ? Colors.grey
                            : Colors.greenAccent),
                  ),
                ),
                IconButton(
                    splashRadius: 18,
                    onPressed: () {
                      _updateAttemptsInc();
                    },
                    icon: const Icon(
                      CupertinoIcons.chevron_forward,
                      color: Colors.white,
                    )),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
