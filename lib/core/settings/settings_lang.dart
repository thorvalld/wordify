import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordify/utils/custom_colors.dart';

List<String> langsArr = [
  "English (US)",
  "Français (FR)",
  "Deutsch (DE)",
  "Norsk Bokmål (NO)",
  "Svensk (SE)",
  "Dansk (DK)"
];

int selectedAppLang = 0;
int selectedWordLang = 0;

late Future<bool> notifs;
late Future<bool> vibrations;

class SettingsLang extends StatefulWidget {
  const SettingsLang({Key? key}) : super(key: key);

  @override
  _SettingsLangState createState() => _SettingsLangState();
}

class _SettingsLangState extends State<SettingsLang> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> updateAppLangSettings(int appLangIndex) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt('settings_app_lang', appLangIndex);
  }

  Future<void> updateWordLangSettings(int wordLangIndex) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt('settings_word_lang', wordLangIndex);
  }

  Future<int> fetchAppLangPrefs() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt('settings_app_lang') ?? 0;
  }

  Future<int> fetchWordLangPrefs() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt('settings_word_lang') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.main_bg,
      body: SafeArea(
          child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
            },
            horizontalTitleGap: 0,
            leading: const Icon(
              CupertinoIcons.arrow_left,
              color: Colors.red,
            ),
            title: const Text(
              "General settings",
              style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w300,
                  fontSize: 12),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const ListTile(
                    title: Text(
                      "App's language",
                      style: TextStyle(
                          color: Colors.amber, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Choose the language of the app.",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 12),
                    ),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: langsArr.length,
                      itemBuilder: (BuildContext builder, int index) {
                        return FutureBuilder<int>(
                            future: null,
                            builder: (context, snapshot) {
                              return FutureBuilder<int>(
                                  future: fetchAppLangPrefs(),
                                  builder: (context, snapshot) {
                                    return ListTile(
                                      onTap: () {
                                        setState(() {
                                          selectedAppLang = index;
                                          updateAppLangSettings(index);
                                        });
                                      },
                                      title: Text(
                                        langsArr[index],
                                        style: TextStyle(
                                            color: snapshot.data == index
                                                ? Colors.white
                                                : Colors.white60,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      trailing: Visibility(
                                        visible: snapshot.data == index
                                            ? true
                                            : false,
                                        child: const Icon(
                                          CupertinoIcons.check_mark,
                                          color: Colors.greenAccent,
                                          size: 18,
                                        ),
                                      ),
                                    );
                                  });
                            });
                      }),
                  const SizedBox(
                    height: 8,
                  ),
                  const ListTile(
                    title: Text(
                      "Words' language",
                      style: TextStyle(
                          color: Colors.amber, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Choose the language of the words in-game.",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 12),
                    ),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: langsArr.length,
                      itemBuilder: (BuildContext builder, int index) {
                        return FutureBuilder<int>(
                            future: fetchWordLangPrefs(),
                            builder: (context, snapshot) {
                              return ListTile(
                                onTap: () {
                                  setState(() {
                                    selectedWordLang = index;
                                    updateWordLangSettings(index);
                                  });
                                },
                                title: Text(
                                  langsArr[index],
                                  style: TextStyle(
                                      color: snapshot.data == index
                                          ? Colors.white
                                          : Colors.white60,
                                      fontWeight: FontWeight.w300),
                                ),
                                trailing: Visibility(
                                  visible:
                                      snapshot.data == index ? true : false,
                                  child: const Icon(
                                    CupertinoIcons.check_mark,
                                    color: Colors.greenAccent,
                                    size: 18,
                                  ),
                                ),
                              );
                            });
                      }),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
