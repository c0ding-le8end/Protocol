import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protocol/common/extensions.dart';
import 'package:protocol/controllers/AuthController.dart';
import 'package:protocol/controllers/question_controller.dart';
import 'package:protocol/models/quiz.dart';
import 'package:protocol/screens/quiz_result_screen.dart';
import 'package:protocol/screens/resultScreen.dart';

import '../common/theme_helper.dart';
import '../gsheets/gsheets_api.dart';
import '../models/dto/option_selection.dart';
import '../models/dto/quiz_result.dart';
import '../models/option.dart';
import '../models/question.dart';
import '../models/quiz_history.dart';
import '../services/quiz_engine.dart';
import '../stores/quiz_store.dart';
import '../widgets/disco_button.dart';
import '../widgets/question_option.dart';
import '../widgets/time_indicator.dart';

class QuizScreen extends StatefulWidget {
  static const routeName = '/quiz';
  QuizScreen( {Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with WidgetsBindingObserver {
  // late QuizEngine engine;
  Question? question;
  double _opacity=1;
  QuestionController controller=Get.find<QuestionController>();
  AuthController authController=Get.find<AuthController>();
  // Timer? progressTimer;
  // AppLifecycleState? state;
  int questionNumber=0;
  Map<int, OptionSelection> _optionSerial = {0:OptionSelection("Always",false),1:OptionSelection("Usually",false),
  2:OptionSelection("Rarely",false),3:OptionSelection("Never",false)};



  @override
  void initState() {
    // engine.start();
question=controller.quiz!.questions![questionNumber];
    super.initState();
    // WidgetsBinding.instance!.addObserver(this);
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   this.state = state;
  // }

  // @override
  // void dispose() {
  //   if (progressTimer != null && progressTimer!.isActive) {
  //     progressTimer!.cancel();
  //   }
  //   engine.stop();
  //   WidgetsBinding.instance!.removeObserver(this);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async
      {
        Navigator.pop(context);
        controller.answers.value=[];
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            decoration: ThemeHelper.fullScreenBgBoxDecoration(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  screenHeader(),
                  AnimatedOpacity(
                    opacity: _opacity,
                    duration: Duration(milliseconds: 500),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: ThemeHelper.roundBoxDeco(),
                      child: Text(
                        question?.text ?? "",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                      opacity: _opacity,
                      duration: Duration(milliseconds: 500),
                      child: questionOptions()),
                  quizProgress(),
              DiscoButton(
                onPressed: () {
                  // setState(() {
                  //   engine.stop();
                  //   if (progressTimer != null && progressTimer!.isActive) {
                  //     progressTimer!.cancel();
                  //   }
                  // });
                  Navigator.pop(context);
                  controller.answers.value=[];

                },
                child: Text(
                  "Cancel",
                  style: TextStyle(fontSize: 20),
                ),
                width: 130,
                height: 50,
              ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget screenHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 5),
      child: Container(
        alignment: Alignment.center,
        child: FittedBox(
          child: Text(
            controller.quiz!.title!,
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget quizQuestion() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 10),
      decoration: ThemeHelper.roundBoxDeco(),
      child: Text(
        question?.text ?? "",
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  Widget questionOptions() {
     int questionIndex=question!.index!;
    return Container(
      alignment: Alignment.center,
      decoration: ThemeHelper.roundBoxDeco(),
      child: SingleChildScrollView(
        child: Column(
          children: List<Option>.from(question?.options ?? []).map((e) {
            int optionIndex = question!.options!.indexOf(e);
            var optWidget = GestureDetector(
              onTap: () async{
                setState(() {
                                      // engine.updateAnswer(quiz.questions.indexOf(question!), optionIndex);
                  // for (int i = 0; i < _optionSerial.length; i++) {
                  //   _optionSerial[i].isSelected = false;
                  // }
                  controller.answers.add(optionIndex);
                  // _optionSerial.update(optionIndex, (value) {
                  //   value.isSelected = true;
                  //
                  //   return value;
                  // });
                  //-------------------------------------------------------------------------------
                    controller.answers[question!.index!-1]=optionIndex;

                    //-------------------------------------------------------------------------------------------------
                });

                switch(optionIndex)
                {
                  case 0:
                    if(controller.quiz!.id!=3)
                    optionIndex=3;
                    break;
                  case 1:
                    if(controller.quiz!.id!=3)
                    optionIndex=2;
                    break;
                  case 2:
                    optionIndex=1;
                    break;
                  case 3:
                    optionIndex=0;
                    break;
                  default:
                    print("217 quiz_screen.dart");
                }
                controller.answers[question!.index!-1]=optionIndex;
                // controller.calculateResult();
                print("171 qs.dart${controller.answers}");
                // print("e===>${controller.personalityScores['Extraverted']}");
                if(question!.index==controller.quiz!.questions!.length)
                {

                  controller.calculateResult();
authController.userData!.setBool(controller.quiz!.title!,true);
                  await GoogleSheetsApi.insert([authController.nameController.text,authController.emailController.text,authController.phoneNumber.text]);
                  // controller.reset();
                  Get.offNamed('/resultScreen');
                }
                else
                {_opacity=0;

                Future.delayed(Duration(milliseconds: 500),()
                {
                  setState(() {
                    _opacity=1;

                    questionNumber=questionNumber+1;
                    question=controller.quiz!.questions![questionNumber];
                    // for(int i=0;i<=3;i++)
                    // {
                    //   _optionSerial[i].isSelected=false;
                    // }
                  });
                });
                }
              },
              child: QuestionOption(
                optionIndex,
                e.text!,
                // isSelected: _optionSerial[optionIndex].isSelected,
              ),
            );
            return optWidget;
          }).toList(),
        ),
      ),
    );
  }

  Widget quizProgress() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            // child: TimeIndicator(
            //   question?.duration ?? 1,
            //   _remainingTime,
            //   () {},
            // ),
          ),
          Text(
            "${question!.index}/${controller.quiz!.questions!.length}",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

//   Widget footerButton() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         DiscoButton(
//           onPressed: () {
//             // setState(() {
//             //   engine.stop();
//             //   if (progressTimer != null && progressTimer!.isActive) {
//             //     progressTimer!.cancel();
//             //   }
//             // });
//             Navigator.pop(context);
//           },
//           child: Text(
//             "Cancel",
//             style: TextStyle(fontSize: 20),
//           ),
//           width: 130,
//           height: 50,
//         ),
//         DiscoButton(
//           onPressed: () {
//             bool optionSelected=false;
//             int optionIndex;
//             for (int i = 0; i < _optionSerial.length; i++) {
//               if(_optionSerial[i].isSelected != false)
//                 {
//                   optionSelected=true;
//                   optionIndex=i;
//                   switch(optionIndex)
//                   {
//                     case 0:
//                       optionIndex=3;
//                       break;
//                     case 1:
//                       optionIndex=2;
//                       break;
//                     case 2:
//                       optionIndex=1;
//                       break;
//                     case 3:
//                       optionIndex=0;
//                       break;
//                     default:
//                       print("217 quiz_screen.dart");
//                   }
//                 }
//             }
//             if(optionSelected==true)
//               {
//                 controller.answers[question.index-1]=optionIndex;
//                 print(controller.answers);
//                 if(question.index==16)
//                 {
//
// controller.calculateResult();
//                       Get.offNamed('/UserForm');
//                 }
//                 else
//                   {
//                     setState(() {
//                       questionNumber=questionNumber+1;
//                       question=controller.quiz.questions[questionNumber];
//                       for(int i=0;i<=3;i++)
//                       {
//                         _optionSerial[i].isSelected=false;
//                       }
//                     });
//                   }
//
//               }
//             // engine.next();
//           },
//           child: Text(
//             "Next",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//           ),
//           isActive: true,
//           width: 130,
//           height: 50,
//         ),
//       ],
//     );
//   }

  void onNextQuestion(Question question) {
    setState(() {
      // if (progressTimer != null && progressTimer!.isActive) {
      //   _remainingTime = 0;
      //   progressTimer!.cancel();
      // }

      this.question = question;
      // _remainingTime = question.duration;
      _optionSerial = {};
      for (var i = 0; i < question.options!.length; i++) {
        _optionSerial[i] = OptionSelection(String.fromCharCode(65 + i), false);
      }
    });

    // Timer.periodic(Duration(seconds: 1), (timer) {
    //   if (_remainingTime >= 0) {
    //     try {
    //       if (mounted) {
    //         setState(() {
    //           progressTimer = timer;
    //           _remainingTime--;
    //         });
    //       }
    //     } catch (ex) {
    //       timer.cancel();
    //       print(ex.toString());
    //     }
    //   }
    // });
  }

  void onQuizComplete(Quiz quiz, double total, Duration takenTime) {
    // if (mounted) {
    //   setState(() {
    //     _remainingTime = 0;
    //   });
    // }
    // progressTimer!.cancel();
    // store.getCategoryAsync(quiz.categoryId).then((category) {
    //   store
    //       .saveQuizHistory(QuizHistory(quiz.id, quiz.title, category.id,
    //           "$total/${quiz.questions.length}", takenTime.format(), DateTime.now(), "Complete"))
    //       .then((value) {
    //     Navigator.pushReplacementNamed(context, QuizResultScreen.routeName,
    //         arguments: QuizResult(quiz, total));
    //   });
    // });
  }

  // void onStop(Quiz quiz) {
  //   _remainingTime = 0;
  //   progressTimer!.cancel();
  // }
}
