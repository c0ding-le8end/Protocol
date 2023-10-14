import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/theme_helper.dart';
import '../controllers/question_controller.dart';
import '../widgets/disco_button.dart';

class StylesScreen extends StatefulWidget {
  StylesScreen(this.style, {Key? key,}) : super(key: key);
  final style;
  static const routeName = '/styles';

  @override
  State<StylesScreen> createState() => _StylesScreenState(style);
}

class _StylesScreenState extends State<StylesScreen> {
  String? style;
  String? name;
  String? description;
  List? strengths;
  List? weaknesses;
  QuestionController controller=Get.find<QuestionController>();
  List stylesList = [
    {
      "type": "authoritative",
      "desc": "This style is based on the idea that leaders should assume personal responsibility for decisions. The authoritative style is attractive to people who are restless, action-oriented, and have a strong personal vision of what’s needed. While the authoritative leader may sometimes ‘consult’ group members before taking decisions, their favoured approach is to take the decisions first and then ‘tell’ or ‘sell’ them to the rest of the group.",
      "strengths": [
        "Group members know exactly where they stand",
        "Decisions can be taken rapidly, which is great in a crisis",
        "Members can concentrate on ‘operational’ tasks, without having to worry about ‘strategic’ issues."
      ],
      "weaknesses": [
        "Unlikely to win full commitment from all group members",
        "Can lead to un-informed and shallow decisions.",
        "Can lead to un-informed and shallow decisions."
      ]
    },
    {
      "type": "democrative",
      "desc": "The leader is determined to include all group members in decisions about how the group should operate. The democratic style is based on a belief that groups cannot be effective unless all members have an opportunity to participate fully.The democratic leader’s role is largely one of establishing a structure and ground-rules for the group, protecting these, and enabling group activity.",
      "strengths": [
        "Gives power to group members",
        "Energises and motivates group members to achieve their tasks",
        "Builds individual responsibility amongst members"
      ],
      "weaknesses": [
        "May slow down tasks, encouraging talk not action",
        "Can frustrate members who like clear direction",
        "Inappropriate when rapid decisions are needed",
        "The most popular decisions are not always the best"
      ]
    },
    {
      "type": "facilitative",
      "desc": "The facilitative style is concerned with offering suggestions which group members may or may not take up. Structure, content and operation of the group are left to group members to determine.While facilitative leaders may have their own clear opinions about the best courses of action, they are not willing to influence the group unduly with their personal ideas. They believe that group activity should be a constant learning process, and that it is OK to make mistakes so long as people learn from them. The journey is seen as more important than the destination.",
      "strengths": [
        "Gives plenty of space for creative ideas to emerge and be explored",
        "Enables individual learning",
        "Can be empowering in the right circumstances"
      ],
      "weaknesses": [
        "Can allow the group to become aimless and chaotic",
        "The leadership ‘gap’ can get filled by other people, who have to operate as ‘informal’ leaders"
      ]
    },
    {
      "type": "situational",
      "desc": "Situational leadership is an approach in which the leader attempts to adapt how they behave according to the needs of each situation. The situational leader will vary their style so that it is appropriate for the particular group (for example, their current levels of skill and confidence), and for the particular task in hand.",
      "strengths": [
        "Allows groups to change over the time.",
        "adapts to urgent and non-urgent situations."
      ],
      "weaknesses": [
        "Difficult to carry off effectively – group members never know what to expect, and may resist changes in style,"
      ]
    }
  ];

  _StylesScreenState(this.style) {
    print("83-ls.dart ${style}");
    for (var element in controller.testWiki!.data!) {
      if (element.type == style) {
        print("here");
        name=element.name!;
        description = element.desc!;
        strengths = element.strengths!;
        weaknesses = element.weaknesses!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Container(alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        decoration: ThemeHelper.fullScreenBgBoxDecoration(),
        child: SingleChildScrollView(child: Column(children: [
          Container(
          alignment: Alignment.center,
          child: Text(
            "${name}",
            style: Theme
                .of(context)
                .textTheme
                .headline4,
          ),
        ),
          Container(alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(10),
              decoration: ThemeHelper.roundBoxDeco(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(description ?? "", style: Theme
                    .of(context)
                    .textTheme
                    .headline5,
                ),)
          ),
          Container(alignment: Alignment.centerLeft,
            margin: EdgeInsets.all(10),
            decoration: ThemeHelper.roundBoxDeco(),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: List.from([
                    Align(alignment: Alignment.centerLeft,
                        child: Text("Strengths", style: TextStyle(fontSize: 30,
                            color: ThemeHelper.primaryColor,
                            fontWeight: FontWeight.bold),))
                  ])
                    ..addAll(List.generate(strengths!.length, (index) =>
                        Align(alignment: Alignment.centerLeft,
                          child: Text.rich(TextSpan(children: [
                            TextSpan(text: "•",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25)),
                            TextSpan(text: strengths![index], style: Theme
                                .of(context)
                                .textTheme
                                .headline5)
                          ]
                          )),
                        )),
                    ),))
            ),
          Container(alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(10),
              decoration: ThemeHelper.roundBoxDeco(),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: List.from([
                      Align(alignment: Alignment.centerLeft,
                          child: Text("Weaknesses", style: TextStyle(fontSize: 30,
                              color: ThemeHelper.primaryColor,
                              fontWeight: FontWeight.bold),))
                    ])
                      ..addAll(List.generate(weaknesses!.length, (index) =>
                          Align(alignment: Alignment.centerLeft,
                            child: Text.rich(TextSpan(children: [
                              TextSpan(text: "•",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 25)),
                              TextSpan(text: weaknesses![index], style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline5)
                            ]
                            )),
                          )),
                      ),))
          ),
          SizedBox(height: 50,),
          DiscoButton(
            onPressed: () {
              Get.back();
            },
            child: FittedBox(
              child: Text(
                "Back",
                style: TextStyle(fontSize: 20, color: ThemeHelper.primaryColor),
              ),
            ),
          )

            ],),),)),
    );
  }
}
