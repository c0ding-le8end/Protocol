import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../common/json_util.dart';

class TestWiki {

  static Future loadWikiData({String id=""}) async {
    List categoryList = [];
    String data = await rootBundle.loadString("assets/data/styles.json");
    var jsonResult = json.decode(data);
    categoryList=List.from(jsonResult.map((model)=>TestWikiObject.fromJson(model)));
    if(id=="")
      {
        return categoryList;
      }

    return categoryList.where((element) => element.id==id).first;

  }
  static Future<TestWikiObject> loadTestData(String id) async {
    List categoryList = [];
    String data = await rootBundle.loadString("assets/data/tests.json");
    var jsonResult = json.decode(data);
    categoryList=List.from(jsonResult.map((model)=>TestData.fromJson(model)));
    return categoryList.firstWhere((element) => element.id==id);

  }
}
class TestData {
  String? id;
  String? name;
  String? type;
  String? shortDesc;

  TestData({this.id, this.name, this.type, this.shortDesc});

  TestData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    shortDesc = json['short_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['short_desc'] = this.shortDesc;
    return data;
  }
}













class TestWikiObject {
  String? id;
  List<Data>? data;

  TestWikiObject({this.id, this.data});

  TestWikiObject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  String? type;
  String? shortDesc;
  String? desc;
  List<String>? strengths;
  List<String>? weaknesses;

  Data(
      {this.name,
        this.type,
        this.shortDesc,
        this.desc,
        this.strengths,
        this.weaknesses});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    shortDesc = json['short_desc'];
    desc = json['desc'];
    strengths = json['strengths'].cast<String>();
    weaknesses = json['weaknesses'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['short_desc'] = this.shortDesc;
    data['desc'] = this.desc;
    data['strengths'] = this.strengths;
    data['weaknesses'] = this.weaknesses;
    return data;
  }
}
