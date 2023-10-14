import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protocol/controllers/AuthController.dart';
import 'package:protocol/controllers/question_controller.dart';
import 'package:protocol/screens/test_screen.dart';

import '../common/theme_helper.dart';
import '../widgets/disco_button.dart';

class ResultScreen extends GetWidget<QuestionController> {
  static const routeName="/resultScreen";
  const ResultScreen({Key? key}) : super(key: key);
  List<Row> generateRows(BuildContext context) {
    List<Row> rows = [];

    if (TestScreen.page == 1) {
      controller.leadershipStyles.forEach((style, percentage) {
        rows.add(buildRow(style, percentage,context));
      });
    } else if (TestScreen.page == 2) {
      controller.conflictStyles.forEach((style, percentage) {
        rows.add(buildRow(style, percentage,context));
      });
    } else if (TestScreen.page == 3) {
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Your Personality Type:", style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white)),
          Text(controller.finalPersonalityType, style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white)),
        ],
      ));

    }

    return rows;
  }

  Row buildRow(String label, dynamic value,BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white)),
        Text("${value.toStringAsFixed(2)}%", style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white)),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      decoration: ThemeHelper.fullScreenBgBoxDecoration(),
      child: SingleChildScrollView(
      child: Column(
        children: [
          Container(margin:const EdgeInsets.all(15),padding:const EdgeInsets.all(15),decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(20)),
            child: Column(mainAxisAlignment:MainAxisAlignment.center,children: generateRows(context).toList(),),
          ),
          DiscoButton(height: 50,
            onPressed: () async {
              Get.find<AuthController>().testCompletionMap[controller.quiz!.title!]=true;
              Get.offAllNamed('/testScreen');
              TestScreen.page=0;
              controller.answers.value=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
              controller.leadershipStyles={'Authoritative':0,'Democratic':0,'Facilitative':0,'Situational':0};
            },
            child: const FittedBox(
              child: Text(
                "Back to menu",
                style: TextStyle(fontSize: 20,),
              ),
            ),
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
          )
        ],
      ),
    ),));
  }
}
