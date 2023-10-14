import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protocol/controllers/question_controller.dart';
import 'package:protocol/screens/test_screen.dart';
import 'package:protocol/stores/test_wiki.dart';

import '../common/theme_helper.dart';
import '../models/category_details.dart';

class AboutPage extends StatefulWidget {
  static const rootName="/AboutPage";

   AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  QuestionController controller=Get.find<QuestionController>();
  var testWikiObject;
@override
  void initState() {
    testWikiObject=TestWiki.loadWikiData(id: TestScreen.page.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Container( alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        decoration: ThemeHelper.fullScreenBgBoxDecoration(),child: SingleChildScrollView(
            child: FutureBuilder(
              future: testWikiObject,
              builder: (context,AsyncSnapshot snapshot) {
                if(snapshot.hasData) {
                  return Column(
                  children: List.from([Row(
                    children: [
                      GestureDetector(
                        child: Image(
                          image: AssetImage("assets/icons/back.png"),
                          width: 40,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        "Leadership Styles",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),],)..addAll(List.from(snapshot.data.data)
                      .map((style) => GestureDetector(
                    child: categoryDetailsItemView(testWikiObjectData:style),
                    onTap: () {
                      Navigator.of(context).pushNamed("/styles", arguments: style.type);
                    },
                  ))
                      .toList())
                );
                } else {
                  return Center(child: CircularProgressIndicator(color: ThemeHelper.protocolMaroon,),);
                }
              }
            ),
          )),),
    );
  }
}
