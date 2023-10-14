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

  _StylesScreenState(this.style) {
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
          DiscoButton(height: 50,
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
