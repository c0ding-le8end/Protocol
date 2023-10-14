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
        decoration: ThemeHelper.fullScreenBgBoxDecoration(),child: SingleChildScrollView(
            child: FutureBuilder(
              future: testWikiObject,
              builder: (context,AsyncSnapshot snapshot) {
                if(snapshot.hasData) {
                  return Column(
                  children: List.from([Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Align(alignment: Alignment.centerLeft,
                      child: FittedBox(
                        child: Row(
                          children: [
                            IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios_new_outlined,color: Theme.of(context).primaryColor,)),
                            Text(
                              snapshot.data!.title!,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),SizedBox(height: 10,)],)..addAll(List.from(snapshot.data!.data!)
                      .map((objectData) => Padding(
                        padding: const EdgeInsets.fromLTRB(10.0,0,10,0),
                        child: GestureDetector(
                                            child: categoryDetailsItemView(testWikiObjectData:objectData,folder: snapshot.data!.folder!,imagePath: snapshot.data!.imagePath),
                                            onTap: () {
                        Navigator.of(context).pushNamed("/styles", arguments: objectData.type);
                                            },
                                          ),
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
