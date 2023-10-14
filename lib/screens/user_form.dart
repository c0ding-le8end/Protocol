import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protocol/common/theme_helper.dart';
import 'package:protocol/controllers/AuthController.dart';
import 'package:protocol/controllers/question_controller.dart';
import 'package:protocol/gsheets/gsheets_api.dart';
import 'package:protocol/screens/home_screen.dart';
import 'package:protocol/screens/quiz_screen.dart';
import 'package:protocol/screens/test_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/animations.dart';
import '../widgets/disco_button.dart';

class UserForm extends StatefulWidget {
  static const routeName = "/UserForm";

  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  AuthController controller = Get.find<AuthController>();
  QuestionController questionController=Get.find<QuestionController>();
  final RegExp phoneNumberRegex = RegExp(r'^[0-9]+$');
  final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      decoration: ThemeHelper.fullScreenBgBoxDecoration(),
      child: Center(
        child: Container(
          width: 450,
          margin: EdgeInsets.all(10),
          child: Form(child: SingleChildScrollView(
            child: Column(

              children: [
                FadeAnimation(
                  0.8, LayoutBuilder(
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
                SizedBox(height: 20,),
                FadeAnimation(1.0,Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text("Fill the form To instantly receive your results:",style: Theme.of(context).textTheme.headline5,),
                )),
                // FadeAnimation(1.2,Text("To instantly receive your results:",style: Theme.of(context).textTheme.headline4,)),
                FadeAnimation(1.0,
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:20.0),
                    child: CustomFormField(hintText:"Name",controller: controller.nameController,),
                  ),
                ),
                FadeAnimation(1.0,
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: CustomFormField(hintText:"Email",controller: controller.emailController,
                      textInputType: TextInputType.emailAddress,),
                  ),
                ),
                FadeAnimation(
                  1.0, Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: CustomFormField(hintText:"Phone Number",controller: controller.phoneNumber,textInputType: TextInputType.phone,maxLength: 10,),
                ),
                ),
                FadeAnimation(1.2,
                  DiscoButton(height: 50,width: 200,
                    onPressed: () async {
                      // await GoogleSheetsApi.insert([controller.nameController.text,controller.emailController.text,controller.phoneNumber.text]);
                      // // controller.reset();
                      // Get.offNamed('/resultScreen');
                      // Get.offNamed('/testScreen');
                      controller.userData!.setString('Name', controller.nameController.text);

                      controller.userData!.setString('Email', controller.emailController.text);

                      controller.userData!.setString('Phone', controller.phoneNumber.text);
                      Get.offAndToNamed(QuizScreen.routeName,arguments: questionController.quiz);
                    },
                    child: FittedBox(
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    isActive: true,
                  ),
                )

              ],),
          ),),
        ),
      ),
    ));
    // return Obx(
    //       () {
    //         if(controller.newUser.value==true) {
    //           return Scaffold(body: Container(
    //     decoration: ThemeHelper.fullScreenBgBoxDecoration(),
    //     child: Center(
    //       child: Container(
    //         width: 450,
    //         margin: EdgeInsets.all(10),
    //         child: Form(child: SingleChildScrollView(
    //           child: Column(
    //
    //             children: [
    //               FadeAnimation(
    //                 0.8, LayoutBuilder(
    //                   builder: (context, constraints) {
    //                     if (constraints.maxWidth < 800) {
    //                       return Padding(
    //                         padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //                         child: Image(
    //                           image: AssetImage("assets/images/protocol_logo.png"),
    //                           width: MediaQuery
    //                               .of(context)
    //                               .size
    //                               .width - 100,
    //                         ),
    //                       );
    //                     } else {
    //                       return Padding(
    //                         padding: const EdgeInsets.symmetric(horizontal: 50.0),
    //                         child: Image(
    //                           image: AssetImage("assets/images/protocol_logo.png"),
    //                           width: MediaQuery
    //                               .of(context)
    //                               .size
    //                               .width - 800,
    //                         ),
    //                       );
    //                     }
    //                   }
    //               ),
    //               ),
    //               SizedBox(height: 20,),
    //               FadeAnimation(1.0,Text("Your Details:",style: Theme.of(context).textTheme.headline4,)),
    //               FadeAnimation(1.0,
    //                  Padding(
    //                 padding: const EdgeInsets.symmetric(vertical:20.0),
    //                 child: CustomFormField(hintText:"Name",controller: controller.nameController,),
    //             ),
    //               ),
    //               FadeAnimation(1.0,
    //                  Padding(
    //                   padding: const EdgeInsets.symmetric(vertical: 20.0),
    //                   child: CustomFormField(hintText:"Email",controller: controller.emailController,
    //                     textInputType: TextInputType.emailAddress,),
    //                 ),
    //               ),
    //               FadeAnimation(
    //                 1.0, Padding(
    //                   padding: const EdgeInsets.symmetric(vertical: 20.0),
    //                   child: CustomFormField(hintText:"Phone Number",controller: controller.phoneNumber,textInputType: TextInputType.phone,maxLength: 10,),
    //                 ),
    //               ),
    //               FadeAnimation(1.2,
    //                 DiscoButton(height: 50,width: 200,
    //                   onPressed: () async {
    //                  // await GoogleSheetsApi.insert([controller.nameController.text,controller.emailController.text,controller.phoneNumber.text]);
    //                  // // controller.reset();
    //                  // Get.offNamed('/resultScreen');
    //                     Get.offNamed('/testScreen');
    //                     controller.userData.setString('Name', controller.nameController.text);
    //
    //                     controller.userData.setString('Email', controller.emailController.text);
    //
    //                     controller.userData.setString('Phone', controller.phoneNumber.text);
    //                   },
    //                   child: FittedBox(
    //                     child: Text(
    //                       "Submit",
    //                       style: TextStyle(fontSize: 20, color: Colors.white),
    //                     ),
    //                   ),
    //                   isActive: true,
    //                 ),
    //               )
    //
    //             ],),
    //         ),),
    //       ),
    //     ),
    //   ));
    //         } else {
    //           return TestScreen();
    //         }
    //       },
    // );
  }
}
//Table(
//
//             children: [TableRow(children: [Text("Name:", style: Theme
//                 .of(context)
//                 .textTheme
//                 .headline4,),
//               CustomFormField(controller: controller.nameController,)]),
//               TableRow(children: [Text("Email:", style: Theme
//                   .of(context)
//                   .textTheme
//                   .headline4,),
//                 CustomFormField(controller: controller.emailController,
//                   textInputType: TextInputType.emailAddress,),
//
//               ]),
//               TableRow(children: [Text("Phone:",style: Theme.of(context).textTheme.headline4,),
//                 CustomFormField(controller: controller.phoneNumber,textInputType: TextInputType.phone,maxLength: 10,)]),
//
//             ],)
class CustomFormField extends StatelessWidget {

  const CustomFormField({
    Key? key,
    @required this.controller,
    this.textInputType = TextInputType.text,
    this.maxLength=30,
    this.hintText=""

  }) : super(key: key);

  final TextEditingController? controller;
  final TextInputType textInputType;
  final int maxLength;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(width: 300,
      height: 50,
decoration: BoxDecoration(border: Border.all(color: ThemeHelper.primaryText,width: 2.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          controller: controller,
          cursorColor: ThemeHelper.primaryText,
          maxLength: maxLength,
          keyboardType:textInputType,
          style: TextStyle(
              fontFamily: "OpenSans", color: ThemeHelper.primaryText,fontWeight: FontWeight.w700),
          decoration:  InputDecoration(counterText:"",border: InputBorder.none,hintText: hintText,hintStyle: TextStyle(color: ThemeHelper.primaryText.withOpacity(0.8),fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
