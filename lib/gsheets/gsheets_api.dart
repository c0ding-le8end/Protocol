// import 'dart:html';

import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:protocol/controllers/question_controller.dart';
import 'package:protocol/screens/test_screen.dart';


class GoogleSheetsApi
{
//   static const _credentials=r'''
//   {
//   "type": "service_account",
//   "project_id": "survey-d7253",
//   "private_key_id": "ad29ec55bbe8f62f1cd52a6b22e36b176950568d",
//   "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDfxvlRBBqX/Ceb\najjBkjmZosgoKnu8RpLqVULEk+chX+stKvcQsAkdF/mGFbAhmtrVw5ei6V9Bk3GL\nJv/s/+a91dJ9gaSjNMRlzFokGUdVfXTZjf9EzOfkTDpFdfDfrw2cTTWR059Yk2J1\nmfU9lrSg0pcoh9imbdw5EpMn5f0GSHK5fKQcwHx5mKW50/IlaAH7GxqZ3KbCJRBC\nYE+rJZ50UuB/WLH+vTZD+EHTMpSatgR+TFyxjLFYOx4tYXdoVNTrCehFaCUDygEs\n8uK9Xrcl2NkUWDNAb/qCR/gtuUNKJevVBuzNvxyAbM4eJGwyXlaYVTbHpFWIzYH8\nz14DXF+fAgMBAAECggEARx75DDuurBFTET0ATt1He0HWNZXS/7K6bMmuT8XmFqBi\noVdfcKlSLDH7dxcbhIKv/HKOlhNv1+qhkqVRf6SRVFJJ9OOoTMqvhN8e4ww5tL0L\nzz0nHVm2dcOYXY0vghgjzkJnvTIyGbe1+kR1Qh7Mx7RGoHYUcEjITkdOB8c71KvH\nxVrYOZ6Y3KGRMpddJ/0EJsHbsDFzGC72ClqN10ZtkTTELIv5JwrkquqXZFRnHlwu\nrFfl+o6M5/9nZsaLhGlSx77cKZhIhsbABbD/8HEgl6XiyLt6fYp9BLTJiRy8Wju5\nXCgKWvlKH4sVqBJVLgCcglVmCWQKi3Jz5MTuJctDYQKBgQD0lU2XqoCYZrHPvAed\nhOafYU9HhoPKTpHj8ObCJOWNyILIH8GObPzTmFWa2IqGvrCuJuh2Jc3rmb0VDjqd\n8qtX9fjRwkIFD3Giu9sbVX+QYt1RoUNjw+3JjfTvutHF7HnzpsZVlWN02syvCYp0\nKKnwSr2VL4pkrjyDMGOHWpmcrwKBgQDqOQurVTix7PF1ATIcnVUTc85TiSzLw/Ex\ncIaXOUiSdsNCWqXUcUqlPQqwIvWwJZnIPminLrYjhs/ygT5L1gjGQd/2tga+27xw\n69zsitmL50VKrWvcnMiojSjpCREi/mtDwbvrjsoiLHAi+YNgMj3TitANeJAUFbVl\nT7LnTdSIEQKBgQCGRe06JV3BzScy/2xC2vJtb1PB1aRGjYnkVJ2q2ey4QOsjiOOP\nGGBYndnpT5YFUWzXvv6B1lFNVbKLe6tMiSvt91ipd3cdJhRhnbY1NGP61XvhU6IW\nhDroGynr7mk5upBc5iMeWwwl2/Tg52D+UlCxXabk3xugGFOaRhdt+Jw6ewKBgQDD\nRyxjfHn4XgQx+P0+vi3gOf0byJKAkKzW+2o7SpcnBb1l5Q29QXdqrKnskDkm0zKT\nsPSv7lIM7KkTFo5Jy/kk0mdX2gtltO43d26KCHm4Gum6iTwUguMJJCenoteWxWfI\n5g03J6V/OG2Fu2G9IiZJ6MHteUcmd7L09K3ECy/XAQKBgCdhEk7Rzx1p3zqgAAe7\nbjPVkK5k5JptXIavXz48foEQqmtZpy8VT+X/+BiESnu9tKngCdlt8/ckzMArtm4k\neJVnEffGWWEuTdP53hXHgOvUHpAoklUfbF4LeYjCZZwmVLeYxzfJ9W5+5o3iKHKs\nJ4I2AiNhluDxvFKcuM+ISWo5\n-----END PRIVATE KEY-----\n",
//   "client_email": "employee-survey@survey-d7253.iam.gserviceaccount.com",
//   "client_id": "103315666664055709326",
//   "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//   "token_uri": "https://oauth2.googleapis.com/token",
//   "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//   "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/employee-survey%40survey-d7253.iam.gserviceaccount.com"
// }
//   ''';
  static final _spreadSheetId="1DTSnoAEqs5JDLmWonabPhy0BPc0wtmmTUxVZSXaMnzs";
  static final _gsheets=GSheets(r'''
          {
  "type": "service_account",
  "project_id": "protocol-7971f",
  "private_key_id": "99b3654a5e457c9bb660cab7dc401c8a5ee814f0",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCyCe65wgnyENpw\neu0GFw05J4nyJKla2lHi6yAw3wwVnxlvvOjpUaE830iuo96h2VMbkRinXWyAfG2j\neActavry+NUootJY/8QiyjQQme5Flw++h5ND7ryAAEjHYmvILtvW2N44pZHgNaL8\nmbLjhwg01bLcUTA0VV37l7odItn0s95+AZJOlRTU3yySk7G3Kfhk515c21sgY/zm\nVi7RYy720QpxZ6PuMWANV13q1zCX175Le093+w9LY6trepyl7b/bRx3Ts8SQfbs1\ntaLgQU8FEWQ1rI4lsG/61o6y4Y47Y6IH/40ugXihaeNZIW6lafkiZiTz2Mnr0pDC\nZ0PcWmDlAgMBAAECgf9kuqKtx00XjQtVL3Bbr3te//vNqzKwAfkeq+4Z1ZDjjuXu\ngd8s/sU0LXpSmBdAo/bYrdjYOQSNz8W7herxHZMv+fL8rdwChoVjFvv2mE8QXpRi\nBBLzjW/H3/cwGIcaQUDxs4RRJ4j5kQ+MoeWwGOWc9FRQTPp8PKcqHiFTnmGVBsD9\nOseyfqrXcwnYeo5wz688GOraIPCliaRSUl/WQdRG3Xap++0PxLjpdOMRRZPXEKL0\nBIVnH8R9Xwhzt5PXET/m56dEihx3lHXArBP6McP38OA/RqWMbKp60eMZij83da70\nrnyCkkFO9iGjk1TnijECbOCsTAWnH1+7kz5WhlkCgYEA9otWILvi2tHKbSgWtCiO\n/tKGbkC1znSNMrOva02CdJ3XssS/5j+DjRDA3T8/FPUFMTDfwn6+s2GRBucQxH0B\n3bzFxhjY3iOxqocaCCofOn4Zmhpu6nLr2tu3Ltcu1LUkohCd6k+pfhrsx6UHyw5+\n2YmHIeesv/Jqv3od3MXnFg8CgYEAuN371ix0+aanmJZKymNFQWX2uvuZulFNXoeq\nE3U1PbLnk8IlL+IQTjjAH59ohOQ6a5J7cClRsrLSjVSaJVsjnYjr9RGkdtxkTDKW\nPnqeqTOjFpJ27TUmwsKCyQXnJTPitYwoFbqh0l6uYPToGdSfZF91v8FmicdzMKlL\nc0ZQ7csCgYEA5aZIpdkdqOI+AouTCmG1QRvs6IoST6s1UwMY5YSffe0BXJ30eo6z\nBRWT8QLWybiqC3YRF+Rj0keRhbJ6Zexjbp5GQw4mBFWPSt7pmq1RxXRseKUip/RA\nSe7bpR//mVbaNrPvxLBLmxGNeTH6HmT0N8HpQ+W/flRapt0jL+CQLnUCgYEAnq81\nX+dzVWR/UhQYCNfjd7qNan1TvMHTFsR+8grW86og7A1nnE2BT5OZHsvXjNLXbsUj\nHejpzul+oIAxfMVZsfz5BbjqInkVwu5dVy4sCPNhF5wLZ5wLNHyAhQuDGMUL4mh3\ndAdqpkhNiL5QiPOhCiiCy2G4oaXJs8huEnoWN7cCgYBqE65gduOioIZnz5/bNah8\np6cQAKKTXg6PgwbMIF7nGGRzmLrN4vHL61nSdQ8B0pXnzrotlohrebQTGAosvMdq\nBFFBKxopgvdNXqyHlmJX7hglE9e+NMdTEFr5aFwYFfA3xZtHvcgFxTepT/M9Em48\nSLIpDAJfFp1OSu8YE0kLng==\n-----END PRIVATE KEY-----\n",
  "client_email": "protocol-7971f@appspot.gserviceaccount.com",
  "client_id": "117095783152290167069",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/protocol-7971f%40appspot.gserviceaccount.com"
}
''');
  static Worksheet? _leadershipData;
  static Worksheet? _conflictData;
  static Worksheet? _personalityData;
  static Future init() async
  {
    final spreadsheet=await _gsheets.spreadsheet(_spreadSheetId);
    _leadershipData= await _getWorkSheet(spreadsheet,title:'leadership');
    _conflictData= await _getWorkSheet(spreadsheet,title:'conflict');
    _personalityData=await _getWorkSheet(spreadsheet,title:'personality');

  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet, {String? title}) async{
    try
    {
      return await spreadsheet.addWorksheet(title!);
    }
    catch(e)
    {
      return spreadsheet.worksheetByTitle(title!)!;
    }
  }

  static Future<Worksheet>? insert(List<dynamic> rowList)
  {
    QuestionController questionController=Get.put<QuestionController>(QuestionController());

    if(TestScreen.page==1&&_leadershipData!=null) {
      rowList.add(questionController.leadershipStyles['Authoritative']);
      rowList.add(questionController.leadershipStyles['Democratic']);
      rowList.add(questionController.leadershipStyles['Facilitative']);
      rowList.add(questionController.leadershipStyles['Situational']);
      _leadershipData!.values.appendRow(rowList);
    }
    else
      if(TestScreen.page==2&&_conflictData!=null)
        {
          _conflictData!.values.appendRow(rowList);
        }
      else
      if(TestScreen.page==3&&_personalityData!=null)
      {
        _personalityData!.values.appendRow(rowList);
      }
    return null;

  }
}