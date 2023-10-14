import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';

import '../common/theme_helper.dart';
import '../stores/test_wiki.dart';

categoryDetailsItemView({Map<String,String>? style,String folder="leadership_styles",Data? testWikiObjectData,bool disabled=false,String? imagePath} ) {
  if(style==null)
    {
      return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(bottom: 20),
        decoration: ThemeHelper.roundBoxDeco(),
        child: HoverContainer(
          hoverColor: ThemeHelper.accentColor.withOpacity(0.4),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        decoration: ThemeHelper.roundBoxDeco(color: Color(0xffE1E9F6), radius: 10),
                        child: Image(errorBuilder: (context,Object exception, StackTrace? stackTrace)
                          {
                            return Image(image: AssetImage(
                                "assets/icons/category/${imagePath!}.png"),width: 130,
                              height: 140,);
                          },
                          image: AssetImage(
                              "assets/icons/${folder}/${testWikiObjectData!.type}.png"),
                          width: 130,
                          height: 140,
                        ),
                      ),
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${testWikiObjectData.name}",
                                style: TextStyle(fontSize: 22,fontFamily: "baloo",fontWeight: FontWeight.w500),
                              ),
                              Text("${testWikiObjectData.shortDesc}",style: TextStyle(fontSize: 18,fontFamily: "OpenSans"),),
                            ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  print(style);
  return Container(
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.only(bottom: 20),
    decoration: disabled?ThemeHelper.roundBoxDeco(color: Colors.grey.withOpacity(0.1)):ThemeHelper.roundBoxDeco(),
    child: HoverContainer(
      hoverColor: ThemeHelper.accentColor.withOpacity(0.4),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    decoration: ThemeHelper.roundBoxDeco(color: Color(0xffE1E9F6), radius: 10),
                    child: Image(
                      image: AssetImage(
                          "assets/icons/${folder}/${style['type']}.png"),
                      width: 130,
                      height: 140,
                    ),
                  ),
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Text(
                              "${style['name']}",
                              style: TextStyle(fontSize: 22,fontFamily: "baloo"),
                            ),
                          ),
                          Text("${style["desc"]}",style: TextStyle(fontSize: 18,fontFamily: "baloo"),),
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}