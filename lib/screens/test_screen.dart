import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protocol/controllers/AuthController.dart';
import 'package:protocol/controllers/question_controller.dart';
import 'package:protocol/models/animations.dart';
import 'package:protocol/screens/quiz_screen.dart';
import 'package:protocol/stores/test_wiki.dart';

import '../common/theme_helper.dart';
import '../models/category_details.dart';
import '../models/dto/option_selection.dart';
import '../stores/quiz_store.dart';
import '../widgets/disco_button.dart';

class TestScreen extends StatefulWidget {
  static const routeName = '/testScreen';
  static int page = 0;

  TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final QuizStore _quizStore = QuizStore();

  QuestionController controller = Get.find<QuestionController>();
AuthController authController=Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{

        setState(() {
          TestScreen.page = 0;
        });
        return false;
      },
      child: SafeArea(
          child: Scaffold(
          body: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(10),
      decoration: ThemeHelper.fullScreenBgBoxDecoration(),
      child: SingleChildScrollView(
      child: Column(
      children: (() {
        if(TestScreen.page == 0) {
          return testSelection!(context);
        } else
          if(TestScreen.page==1) {
            return leadershipButtons!(context,
                title: "Take the test!",
                routeString: '/AboutPage',
                image: 'leadership',
                id:1,
                about: "About Leadership styles");
          } else
          if(TestScreen.page==2) {
            return leadershipButtons(context,
                title: "Take the test!",
                routeString: '/AboutPage',
                image: 'conflict-management',
                id:2,
                about: "About Conflict management");
          } else if(TestScreen.page==3)
            {
             return leadershipButtons(context,
                  title: "Take the Test!",
                  routeString: '/AboutPage',
                  image: 'personality',
                  id:3,
                  about: "The 16 Personality Types");
            }
        return <Widget>[];
      }())
      ,
      )),)
      ),
      ),
    );
  }

  List<Widget> testSelection(BuildContext context) {
    return List.from(
      [SizedBox(height: 60),  FadeAnimation(
        1.0, LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 800) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Image(
                    image: AssetImage("assets/images/protocol_logo.png"),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 100,
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Image(
                    image: AssetImage("assets/images/protocol_logo.png"),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 800,
                  ),
                );
              }
            }
        ),
      ),
        SizedBox(height: 30),
        // Row(
        //   children: [
        //     GestureDetector(
        //       child: Image(
        //         image: AssetImage("assets/icons/back.png"),
        //         width: 40,
        //       ),
        //       onTap: () {
        //         Get.offNamed('/home');
        //       },
        //     ),
        //     Text(
        //       "Protocol",
        //       style: Theme.of(context).textTheme.headline4,
        //     ),
        //   ],
        // ),
      ],
    )
      ..addAll([
        {'id': "1",
          'name': 'Leadership Styles',
          'type': 'leadership',
          'desc': 'Discover your preferred leadership style'
        },
        {'id': "2",
          'name': 'Conflict Management',
          'type': 'conflict-management',
          'desc': 'Think about how you usually respond to conflict'
        },
        {'id': "3",
          'name': 'Personality Test',
          'type': 'personality',
          'desc': 'Think about how you usually respond to conflict'
        },
      ]
          .map((style) =>
           Builder(
             builder: (context) {
               return FadeAnimation(
                 1.2, GestureDetector(
                  child: categoryDetailsItemView(style: style, folder: "category",disabled: authController.testCompletionMap[style['name']]!),
                  onTap: authController.testCompletionMap[style['name']]==false?() async {
                    setState(() {
                      TestScreen.page = int.parse(style['id']!);
                    });try{
                      await TestWiki.loadWikiData(id: style['id']!).then((value) {
                        controller.testWiki = value;
                        print("97-Testscreen.dart ${controller.testWiki}");
                      });
                    }
                    catch(e)
                    {
                      print(e);
                    }
                  }:()=>null,
          ),
               );
             }
           ),
          )
          .toList());
  }

  List<Widget> leadershipButtons(BuildContext context,
      {String title = "", String about = "", String routeString = "", String image = "", int id = 1}) {
    return [
      FadeAnimation(1.8,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(image: AssetImage('assets/icons/category/${image}.png'),
            height: MediaQuery
                .of(context)
                .size
                .height / 3,
            width: MediaQuery
                .of(context)
                .size
                .width / 3,),
        ),
      ),
      FadeAnimation(
        2.0,
        DiscoButton(
          onPressed: () async {
            print("168 test screen $id");
            await controller.store!.getQuizByIdAsync(id, id).then((value) {
              controller.quiz = value;
              int i = 0;
              for (var element in controller.quiz!.questions![0].options!) {
                controller.optionSerial.assign(
                    i, OptionSelection(element.text!, false));
              }
              print("149 test screen ${controller.optionSerial[0]!.optionText}");
            });
Get.toNamed('/UserForm');
            // Navigator.pushNamed(
            //     context, QuizScreen.routeName, arguments: controller.quiz);
          },
          child: FittedBox(
            child: Text(
              title,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          isActive: true,
        ),
      ),
      FadeAnimation(
        2.0,
        DiscoButton(
          onPressed: () {
            Get.toNamed(routeString);
          },
          child: FittedBox(
            child: Text(
              about,
              style: TextStyle(fontSize: 20, color: ThemeHelper.primaryText),
            ),
          ),
        ),
      ),
      SizedBox(height: 40,),
      FadeAnimation(
        2.0, DiscoButton(width: 130,
        height: 50,
        onPressed: () async {
          setState(() {
            TestScreen.page = 0;
          });
        },
        child: Text(
          "Back to menu",
          style: TextStyle(fontSize: 20, color: ThemeHelper.primaryText),
        ),
        isActive: false,
      ),
      )
      // DiscoButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, QuizHistoryScreen.routeName);
      //   },
      //   child: Text(
      //     "Quiz History",
      //     style: TextStyle(fontSize: 30, color: ThemeHelper.primaryColor),
      //   ),
      // ),
    ];
  }
}
