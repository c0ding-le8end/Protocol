
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:protocol/controllers/question_controller.dart';
import 'package:protocol/gsheets/gsheets_api.dart';
import 'package:protocol/stores/test_wiki.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_strategy/url_strategy.dart';

// ignore: avoid_web_libraries_in_flutter
// import 'dart:html';
import 'common/route_generator.dart';
import 'common/theme_helper.dart';
import 'controllers/AuthController.dart';
import 'stores/quiz_store.dart';
//#c500d1
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await QuizStore.initPrefs();

//   if(UniversalPlatform.isWeb)
//     {
//       if(window.localStorage['gsheetsData']==null)
//         {
//           window.localStorage['gsheetsData']=r'''
//           {
//   "type": "service_account",
//   "project_id": "protocol-7971f",
//   "private_key_id": "99b3654a5e457c9bb660cab7dc401c8a5ee814f0",
//   "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCyCe65wgnyENpw\neu0GFw05J4nyJKla2lHi6yAw3wwVnxlvvOjpUaE830iuo96h2VMbkRinXWyAfG2j\neActavry+NUootJY/8QiyjQQme5Flw++h5ND7ryAAEjHYmvILtvW2N44pZHgNaL8\nmbLjhwg01bLcUTA0VV37l7odItn0s95+AZJOlRTU3yySk7G3Kfhk515c21sgY/zm\nVi7RYy720QpxZ6PuMWANV13q1zCX175Le093+w9LY6trepyl7b/bRx3Ts8SQfbs1\ntaLgQU8FEWQ1rI4lsG/61o6y4Y47Y6IH/40ugXihaeNZIW6lafkiZiTz2Mnr0pDC\nZ0PcWmDlAgMBAAECgf9kuqKtx00XjQtVL3Bbr3te//vNqzKwAfkeq+4Z1ZDjjuXu\ngd8s/sU0LXpSmBdAo/bYrdjYOQSNz8W7herxHZMv+fL8rdwChoVjFvv2mE8QXpRi\nBBLzjW/H3/cwGIcaQUDxs4RRJ4j5kQ+MoeWwGOWc9FRQTPp8PKcqHiFTnmGVBsD9\nOseyfqrXcwnYeo5wz688GOraIPCliaRSUl/WQdRG3Xap++0PxLjpdOMRRZPXEKL0\nBIVnH8R9Xwhzt5PXET/m56dEihx3lHXArBP6McP38OA/RqWMbKp60eMZij83da70\nrnyCkkFO9iGjk1TnijECbOCsTAWnH1+7kz5WhlkCgYEA9otWILvi2tHKbSgWtCiO\n/tKGbkC1znSNMrOva02CdJ3XssS/5j+DjRDA3T8/FPUFMTDfwn6+s2GRBucQxH0B\n3bzFxhjY3iOxqocaCCofOn4Zmhpu6nLr2tu3Ltcu1LUkohCd6k+pfhrsx6UHyw5+\n2YmHIeesv/Jqv3od3MXnFg8CgYEAuN371ix0+aanmJZKymNFQWX2uvuZulFNXoeq\nE3U1PbLnk8IlL+IQTjjAH59ohOQ6a5J7cClRsrLSjVSaJVsjnYjr9RGkdtxkTDKW\nPnqeqTOjFpJ27TUmwsKCyQXnJTPitYwoFbqh0l6uYPToGdSfZF91v8FmicdzMKlL\nc0ZQ7csCgYEA5aZIpdkdqOI+AouTCmG1QRvs6IoST6s1UwMY5YSffe0BXJ30eo6z\nBRWT8QLWybiqC3YRF+Rj0keRhbJ6Zexjbp5GQw4mBFWPSt7pmq1RxXRseKUip/RA\nSe7bpR//mVbaNrPvxLBLmxGNeTH6HmT0N8HpQ+W/flRapt0jL+CQLnUCgYEAnq81\nX+dzVWR/UhQYCNfjd7qNan1TvMHTFsR+8grW86og7A1nnE2BT5OZHsvXjNLXbsUj\nHejpzul+oIAxfMVZsfz5BbjqInkVwu5dVy4sCPNhF5wLZ5wLNHyAhQuDGMUL4mh3\ndAdqpkhNiL5QiPOhCiiCy2G4oaXJs8huEnoWN7cCgYBqE65gduOioIZnz5/bNah8\np6cQAKKTXg6PgwbMIF7nGGRzmLrN4vHL61nSdQ8B0pXnzrotlohrebQTGAosvMdq\nBFFBKxopgvdNXqyHlmJX7hglE9e+NMdTEFr5aFwYFfA3xZtHvcgFxTepT/M9Em48\nSLIpDAJfFp1OSu8YE0kLng==\n-----END PRIVATE KEY-----\n",
//   "client_email": "protocol-7971f@appspot.gserviceaccount.com",
//   "client_id": "117095783152290167069",
//   "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//   "token_uri": "https://oauth2.googleapis.com/token",
//   "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//   "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/protocol-7971f%40appspot.gserviceaccount.com"
// }
// ''';
//         }
//       GoogleSheetsApi.init();
//     }
// setPathUrlStrategy();
  GoogleSheetsApi.init();
      runApp(QuizApp(type: '/testScreen'));



}

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key, this.type}) : super(key: key);
 final String? type;

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  AssetImage? image;
  @override
  void initState() {
   image=AssetImage("assets/images/Common.bg.png");
    super.initState();
  }
  @override
  void didChangeDependencies() {
    precacheImage(image!, context);
    super.didChangeDependencies();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Flutter Quiz App',
      theme: ThemeHelper.getThemeData(),
      debugShowCheckedModeBanner: false,
      initialRoute: widget.type,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialBinding: QuestionBindings(),
    );

  }
}
class QuestionBindings extends Bindings
{
  @override
  void dependencies() {
    Get.put<QuestionController>(QuestionController());
     Get.put<AuthController>(AuthController());
    // TODO: implement dependencies
  }

}
