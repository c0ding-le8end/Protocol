import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController
{
  TextEditingController nameController=TextEditingController(text:"");
  TextEditingController emailController=TextEditingController(text: "");
  TextEditingController phoneNumber=TextEditingController(text: "");
  SharedPreferences? userData;
  RxBool newUser=RxBool(true);
  Map<String,bool> testCompletionMap={'Conflict Management':false,"Leadership Styles":false,"Personality Test":false};
  @override
  void onInit() async{
    userData=await SharedPreferences.getInstance();
userData!.clear();
    print("$userData 17ac.dart");
    if(userData!.getBool("Leadership Styles")==true)
      {
testCompletionMap["Leadership Styles"]=true;
      }
    if(userData!.getBool("Conflict Management")==true)
    {
      testCompletionMap["Conflict Management"]=true;
    }
    if(userData!.getBool("Personality Test")==true)
    {
      testCompletionMap["Personality Test"]=true;
    }
    // if(userData.getString('Name')==null||userData.getString('Email')==null||userData.getString('Phone')==null)
    // {
    //   newUser.value=true;
    // }
    // else
    // {nameController.text=userData.getString('Name');
    // emailController.text=userData.getString('Email');
    // phoneNumber.text=userData.getString(('Phone'));
    // newUser.value=false;
    // }
    print("25ac.dart $newUser");

    super.onInit();
  }
  void reset()
  {
    nameController.text="";
    emailController.text="";
    phoneNumber.text="";
  }
  void uploadData()
  {

  }
}