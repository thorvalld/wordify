import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordify/utils/custom_colors.dart';
import 'package:wordify/widgets/wordify_toasts.dart';

TextEditingController _mailController = TextEditingController();
TextEditingController _usernameController = TextEditingController();
TextEditingController _messageController = TextEditingController();



class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  bool isToastVisible = false;
  int selectedReviewValue = 0;
  void onReviewChange(int value) {
    setState(() {
      selectedReviewValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.main_bg,
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 22,
          ),
          const ListTile(
              title: Text(
                "Feedback",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
              subtitle: Text(
                "Send us your thoughts, we accept ideas, suggestions and bug reports.",
                style: TextStyle(
                  color: Colors.white60,
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 3),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.1),
                      borderRadius: BorderRadius.circular(6)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _mailController,
                          cursorColor: Colors.amber,
                          maxLines: 1,
                          style: const TextStyle(color: Colors.amber),
                          decoration: const InputDecoration(
                              prefixIcon: Icon(CupertinoIcons.mail,
                                  color: Colors.amber),
                              hintText: "Your e-mail",
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey),
                              border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 3),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.1),
                      borderRadius: BorderRadius.circular(6)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _usernameController,
                          maxLines: 1,
                          cursorColor: Colors.amber,
                          style: const TextStyle(color: Colors.amber),
                          decoration: const InputDecoration(
                              prefixIcon: Icon(CupertinoIcons.person,
                                  color: Colors.amber),
                              hintText: "Your name",
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey),
                              border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 3),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.1),
                      borderRadius: BorderRadius.circular(6)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          maxLines: 10,
                          cursorColor: Colors.amber,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              hintText: "Start typing your message",
                              contentPadding: EdgeInsets.all(12),
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey),
                              border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          /*
          const ListTile(
              title: Text(
                "Leave us a review",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
              subtitle: Text(
                "How do you find Wordify so far?",
                style: TextStyle(
                  color: Colors.white60,
                ),
              )),
          const SizedBox(
            height: 6,
          ),
          ListTile(
            horizontalTitleGap: 0,
            subtitle: ReviewSlider(
              width: double.infinity,
              circleDiameter: 64,
              optionStyle: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 9),
              onChange: onReviewChange,
              initialValue: 4,
            ),
          ),
          */
          const Spacer(),
          WordifyDisplayToast(displayWidget: const WordifyInProgress(displayIcon: Icons.outgoing_mail, displayMessage: 'Sending...',), isVis: isToastVisible,),
          Container(
            margin: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                      color: Colors.amber,
                      child: const Text("SEND FEEDBACK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          isToastVisible = !isToastVisible;
                        });
                      }),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                      child: const Text(
                        "cancel",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
