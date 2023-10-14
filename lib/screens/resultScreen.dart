import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protocol/controllers/AuthController.dart';
import 'package:protocol/controllers/question_controller.dart';
import 'package:protocol/screens/test_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/theme_helper.dart';
import '../widgets/disco_button.dart';
import 'about_page.dart';

class ResultScreen extends GetWidget<QuestionController> {
  static const routeName="/resultScreen";
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      decoration: ThemeHelper.fullScreenBgBoxDecoration(),
      child: SingleChildScrollView(
      child: Column(mainAxisAlignment:MainAxisAlignment.center,children: [
        if(TestScreen.page==1)
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Authoritative',style:Theme.of(context).textTheme.headline3,),
          Text(
            "${controller.leadershipStyles['Authoritative'].toStringAsFixed(2)}%",
            style: TextStyle(
              fontSize: 25,
              color: Theme.of(context).primaryColor,
            ),
          ),

        ],
      ),
        if(TestScreen.page==1)
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Democratic',style:Theme.of(context).textTheme.headline3,),
            Text(
              "${controller.leadershipStyles['Democratic'].toStringAsFixed(2)}%",
              style: TextStyle(
                fontSize: 25,
                color: Theme.of(context).primaryColor,
              ),
            ),

          ],
        ),
        if(TestScreen.page==1)
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Facilitative',style:Theme.of(context).textTheme.headline3,),
            Text(
              "${controller.leadershipStyles['Facilitative'].toStringAsFixed(2)}%",
              style: TextStyle(
                fontSize: 25,
                color: Theme.of(context).primaryColor,
              ),
            ),

          ],
        ),
        if(TestScreen.page==1)
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Situational',style:Theme.of(context).textTheme.headline3,),
            Text(
              "${controller.leadershipStyles['Situational'].toStringAsFixed(2)}%",
              style: TextStyle(
                fontSize: 25,
                color: Theme.of(context).primaryColor,
              ),
            ),

          ],
        ),
        if(TestScreen.page==2)
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Give In',style:Theme.of(context).textTheme.headline3,),
              Text(
                "${controller.conflictStyles['GiveIn'].toStringAsFixed(2)}%",
                style: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).primaryColor,
                ),
              ),

            ],
          ),
        if(TestScreen.page==2)
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Run Away',style:Theme.of(context).textTheme.headline3,),
              Text(
                "${controller.conflictStyles['RunAway'].toStringAsFixed(2)}%",
                style: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).primaryColor,
                ),
              ),

            ],
          ),
        if(TestScreen.page==2)
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Team Up',style:Theme.of(context).textTheme.headline3,),
              Text(
                "${controller.conflictStyles['TeamUp'].toStringAsFixed(2)}%",
                style: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).primaryColor,
                ),
              ),

            ],
          ),
        if(TestScreen.page==2)
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Pressure',style:Theme.of(context).textTheme.headline3,),
              Text(
                "${controller.conflictStyles['Pressure'].toStringAsFixed(2)}%",
                style: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).primaryColor,
                ),
              ),

            ],
          ),
        if(TestScreen.page==2)
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Compromise',style:Theme.of(context).textTheme.headline3,),
              Text(
                "${controller.conflictStyles['Compromise'].toStringAsFixed(2)}%",
                style: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).primaryColor,
                ),
              ),

            ],
          ),
        if(TestScreen.page==3)
          Text("Your Personality Type:",style: Theme.of(context).textTheme.headline3,),
        if(TestScreen.page==3)
          Text(controller.finalPersonalityType,style: Theme.of(context).textTheme.headline3,),
        DiscoButton(
          onPressed: () async {
          Get.find<AuthController>().testCompletionMap[controller.quiz!.title!]=true;
            Get.offAllNamed('/testScreen');
            TestScreen.page=0;
            controller.answers.value=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
            controller.leadershipStyles={'Authoritative':0,'Democratic':0,'Facilitative':0,'Situational':0};
          },
          child: FittedBox(
            child: Text(
              "Back to menu",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          isActive: true,
        ),
        DiscoButton(
          onPressed: () {
            Get.toNamed('/AboutPage');
          },
          child: FittedBox(
            child: Text(
              "About Leadership styles",
              style: TextStyle(fontSize: 20, color: ThemeHelper.primaryColor),
            ),
          ),
        ),],),
    ),));
  }
}
