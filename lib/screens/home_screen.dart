import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:protocol/models/animations.dart';
import 'package:protocol/screens/about_page.dart';

import '../common/alert_util.dart';
import '../common/theme_helper.dart';
import '../stores/quiz_store.dart';
import '../widgets/disco_button.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final QuizStore _quizStore = QuizStore();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return  false;
      },
      child: SafeArea(
        child: Scaffold(
          key: _key,
          // drawer: navigationDrawer(),
          body: Container(
            alignment: Alignment.center,
            decoration: ThemeHelper.fullScreenBgBoxDecoration(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // drawerToggleButton(),
                  Column(
                    children: [
                      SizedBox(height: 60),
                      // headerText("Protocol"),
                     FadeAnimation(
                       0.8, LayoutBuilder(
                         builder: (context,constraints) {
                           if(constraints.maxWidth<800)
                           return Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 20.0),
                             child: Image(
                               image: AssetImage("assets/images/protocol_logo.png"),
                               width: MediaQuery.of(context).size.width -100,
                             ),
                           );
                           else
                             return Padding(
                               padding: const EdgeInsets.symmetric(horizontal: 50.0),
                               child: Image(
                                 image: AssetImage("assets/images/protocol_logo.png"),
                                 width: MediaQuery.of(context).size.width -800,
                               ),
                             );
                         }
                       ),
                     ),
                      SizedBox(height: 30),
              FadeAnimation(
                2.0, DiscoButton(
                onPressed: () async {
                Get.offNamed('/testScreen');
                },
                child: FittedBox(
                  child: Text(
                    "Lets Go!",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                isActive: true,
              ),
              ),
                      // if(page==0)
                      //     ...leadershipButtons(context)
                      // else
                      //   Container(height: 100,color: Colors.red,)


                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Drawer navigationDrawer() {
  //   return Drawer(
  //     child: ListView(
  //       padding: EdgeInsets.zero,
  //       children: [
  //         DrawerHeader(
  //           decoration: BoxDecoration(
  //             color: Colors.deepPurple,
  //           ),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: const [
  //               Text(
  //                 "Quiz App",
  //                 style: TextStyle(color: Colors.white, fontSize: 32),
  //               ),
  //               Text(
  //                 "Version: 1.00",
  //                 style: TextStyle(color: Colors.white, fontSize: 16),
  //               ),
  //             ],
  //           ),
  //         ),
  //         ListTile(
  //           title: const Text('Home'),
  //           onTap: () {
  //             Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  //           },
  //         ),
  //         ListTile(
  //           title: const Text('Start Quiz'),
  //           onTap: () async {
  //             var quiz = await _quizStore.getRandomQuizAsync();
  //             Navigator.pushNamed(context, "/quiz", arguments: quiz);
  //           },
  //         ),
  //         ListTile(
  //           title: const Text('Quiz Category'),
  //           onTap: () {
  //             Navigator.pushNamed(context, QuizCategoryScreen.routeName);
  //           },
  //         ),
  //         ListTile(
  //           title: const Text('Quiz History'),
  //           onTap: () {
  //             Navigator.pushNamed(context, QuizHistoryScreen.routeName);
  //           },
  //         ),
  //         Divider(
  //           thickness: 2,
  //         ),
  //         ListTile(
  //           title: const Text('About'),
  //           onTap: () {
  //             AlertUtil.showAlert(context, "About us", "More at https://fluttertutorial.net");
  //           },
  //         ),
  //         ListTile(
  //           title: const Text('Exit'),
  //           onTap: () {
  //             if (Platform.isAndroid) {
  //               SystemNavigator.pop();
  //             } else if (Platform.isIOS) {
  //               exit(0);
  //             }
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget drawerToggleButton() {
  //   return Container(
  //     padding: EdgeInsets.only(top: 20, left: 20),
  //     alignment: Alignment.topLeft,
  //     child: GestureDetector(
  //       child: Image(
  //         image: AssetImage("assets/icons/menu.png"),
  //         width: 36,
  //       ),
  //       onTap: () {
  //         _key.currentState!.openDrawer();
  //       },
  //     ),
  //   );
  // }

  Text headerText(String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 72,
          color: ThemeHelper.accentColor,
          fontWeight: FontWeight.bold,
          shadows: [Shadow(color: ThemeHelper.shadowColor, offset: Offset(-5, 5), blurRadius: 30)]),
    );
  }
  List<Widget> AssertiveButtons(BuildContext context) {
    return [
      FadeAnimation(
        2.0, DiscoButton(
        onPressed: () async {
          var quiz = await _quizStore.getQuizByIdAsync(1, 1);
          Navigator.pushNamed(context, QuizScreen.routeName, arguments: quiz);
        },
        child: FittedBox(
          child: Text(
            "Know Your Leadership Style!",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        isActive: true,
      ),
      ),
      FadeAnimation(
        2.0, DiscoButton(
        onPressed: () {
          Get.toNamed('/AboutPage');
        },
        child: FittedBox(
          child: Text(
            "About Leadership styles",
            style: TextStyle(fontSize: 20, color: ThemeHelper.primaryText),
          ),
        ),
      ),
      ),
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
