import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:protocol/screens/test_screen.dart';
import 'package:protocol/stores/test_wiki.dart';

import '../models/Questions.dart';
import '../models/dto/option_selection.dart';
import '../models/quiz.dart';
import '../stores/quiz_store.dart';

// We use get package for our state management

class QuestionController extends GetxController {
  RxList answers = RxList([]);
  QuizStore? store;
  Quiz? quiz;
  TestWikiObject? testWiki;
  TestData? testData;
  Map leadershipStyles = {
    'Authoritative': 0,
    'Democratic': 0,
    'Facilitative': 0,
    'Situational': 0
  };
  Map conflictStyles = {
    'GiveIn': 0,
    'RunAway': 0,
    'TeamUp': 0,
    'Pressure': 0,
    'Compromise': 0
  };
  Map<String,Map<int,String>> personalityTypes = {
    'E': {
      3: '2a',
      6: '2a',
      9: '2a',
      13: '1a',
      16: '2a',
      21: '2a',
      24: '1a',
      26: '1a',
      29: '2b',
      36: '2b',
      43: '1b'
    },
    'I': {
      3: '2b',
      6: '1b',
      9: '1b',
      13: '2b',
      16: '2b',
      21: '2b',
      24: '1b',
      26: '0b',
      29: '2a',
      36: '1a',
      43: '1a'
    },
    'S': {
     2: '2a',
      5: '1b',
      10: '1a',
      12: '1a',
      15: '1b',
      20: '2a',
     23: '2b',
      28: '2a',
      31: '2b',
      35: '2a',
      38: '2b',
      42: '1a',
      45: '2b',
      48: '1a',
    },
    'N': {
      2: '2b',
      5: '1a',
      10: '2b',
      12: '2b',
      15: '0a',
      20: '2b',
      23: '1a',
      28: '1b',
      31: '0a',
      35: '1b',
      38: '0a',
      42: '2b',
      45: '0a',
      48: '1b',
    },
    'T': {
      4: '2b',
      14: '2b',
      22: '2b',
      30: '2a',
      32: '1a',
      33: '2b',
      37: '1a',
      39: '1a',
      40: '2b',
      44: '1a',
      46: '2a',
      47: '2b',
      49: '2a',
      50: '2a'
    },
    'F': {
      4: '1a',
      14:'1a',
      22: '2a',
     30: '1b',
      32: '1b',
      33: '0a',
      37: '2b',
      39: '1b',
      40: '1a',
      44: '2b',
      46: '0b',
      47: '1a',
      49: '1b',
      50: '0b'
    },
    'J': {
      1: '2a',
      7: '1a',
      8: '1a',
      11: '2a',
      17: '2a',
      18: '1a',
      19: '1a',
      25: '1a',
      27: '2a',
      34: '2a',
      41: '2a'
    },
    'P': {
      1: '2b',
      7: '1b',
      8: '2b',
      11:'1b',
      17: '2b',
      18: '1b',
      19: '1b',
      25: '1b',
      27: '2b',
      34: '2b',
      41: '2b'
    }
  };
  Map personalityScores = {
    'Introverted': 0,
    'Extraverted': 0,
    'Intuitive(N)': 0,
    'Sensing': 0,
    'Thinking': 0,
    'Feeling': 0,
    'Judging': 0,
    'Perceiving': 0
  };
  Map<int, OptionSelection> optionSerial = {
    0: OptionSelection("Always", false),
    1: OptionSelection("Usually", false),
    2: OptionSelection("Rarely", false),
    3: OptionSelection("Never", false)
  };
  String finalPersonalityType = "";

  @override
  void onInit() {
    store = QuizStore();

    // TODO: implement onInit
    super.onInit();
  }

  void calculateResult() {
    if (TestScreen.page == 1) {
      leadershipStyles['Authoritative'] =
          (answers[3] + answers[5] + answers[11] + answers[13]) / 12 * 100;
      leadershipStyles['Democratic'] =
          (answers[0] + answers[7] + answers[10] + answers[12]) / 12 * 100;
      leadershipStyles['Facilitative'] =
          (answers[1] + answers[6] + answers[8] + answers[15]) / 12 * 100;
      leadershipStyles['Situational'] =
          (answers[2] + answers[4] + answers[9] + answers[14]) / 12 * 100;
    } else if (TestScreen.page == 2) {
      conflictStyles['GiveIn'] =
          (answers[2] + answers[10] + answers[13]) / 12 * 100;
      conflictStyles['RunAway'] =
          (answers[5] + answers[9] + answers[14]) / 12 * 100;
      conflictStyles['TeamUp'] =
          (answers[0] + answers[4] + answers[6]) / 12 * 100;
      conflictStyles['Pressure'] =
          (answers[3] + answers[8] + answers[11]) / 12 * 100;
      conflictStyles['Compromise'] =
          (answers[1] + answers[7] + answers[12]) / 12 * 100;
      print("104 qc.dart ${answers[0]}");
      print("105 qc.dart ${answers[4]}");
      print("106 qc.dart ${answers[6]}");
    } else if (TestScreen.page == 3) {
      personalityScores = {
        'Introverted': 0,
        'Extraverted': 0,
        'Intuitive(N)': 0,
        'Sensing': 0,
        'Thinking': 0,
        'Feeling': 0,
        'Judging': 0,
        'Perceiving': 0
      };
      for (int i = 0; i < answers.length; i++) {
        var element = answers[i];
        int testString1=0;
        int testString2=0;
        String option1="",option2="";
        int q = i + 1;
        if(q==7&&element==2)
          {
            personalityScores['Perceiving']+=1;
          }
        else
          if(q==25 && element==2)
            {
              personalityScores['Judging'] += 0;
            }
          else
        if (q == 3 ||
            q == 6 ||
            q == 9 ||
            q == 13 ||
            q == 16 ||
            q == 21 ||
            q == 24 ||
            q == 26 ||
            q == 29 ||
            q == 36 ||
            q == 43) {
          testString1=int.parse(personalityTypes['E']![q]!.substring(0,personalityTypes['E']![q]!.length-1));
          option1=personalityTypes['E']![q]![personalityTypes['E']![q]!.length-1];
          option2=personalityTypes['I']![q]![personalityTypes['I']![q]!.length-1];
          testString2=int.parse(personalityTypes['I']![q]!.substring(0,personalityTypes['I']![q]!.length-1));
          switch (element) {
            case 0:
if(option1=='a') {
  personalityScores['Extraverted'] += testString1;
} else {
  personalityScores['Introverted'] += testString2;
}
              break;
            case 1:
              if(option1=='b') {
                personalityScores['Extraverted'] += testString1;
              } else {
                personalityScores['Introverted'] += testString2;
              }
              break;
            default:
              print("119:qc.dart");
          }
        } else if (q == 2 ||
            q == 5 ||
            q == 10 ||
            q == 12 ||
            q == 15 ||
            q == 20 ||
            q == 23 ||
            q == 28 ||
            q == 31 ||
            q == 35 ||
            q == 38 ||
            q == 42 ||
            q == 45 ||
            q == 48) {
          testString1=int.parse(personalityTypes['N']![q]!.substring(0,personalityTypes['N']![q]!.length-1));
          option1=personalityTypes['N']![q]![personalityTypes['N']![q]!.length-1];
          option2=personalityTypes['S']![q]![personalityTypes['S']![q]!.length-1];
          testString2=int.parse(personalityTypes['S']![q]!.substring(0,personalityTypes['S']![q]!.length-1));
          switch (element) {
            case 0:
              if(option1=='a') {
                personalityScores['Intuitive(N)'] += testString1;
              } else {
                personalityScores['Sensing'] += testString2;
              }
              break;
            case 1:
              if(option1=='b') {
                print("N added");
                personalityScores['Intuitive(N)'] += testString1;
              } else {
                print("S added");
                personalityScores['Sensing'] += testString2;
              }
              break;
            default:
              print("134:qc.dart");
          }
        } else if (q == 4 ||
            q == 14 ||
            q == 22 ||
            q == 30 ||
            q == 32 ||
            q == 33 ||
            q == 37 ||
            q == 39 ||
            q == 40 ||
            q == 44 ||
            q == 46 ||
            q == 47 ||
            q == 49 ||
            q == 50) {
          testString1=int.parse(personalityTypes['T']![q]!.substring(0,personalityTypes['T']![q]!.length-1));
          option1=personalityTypes['T']![q]![personalityTypes['T']![q]!.length-1];
          option2=personalityTypes['F']![q]![personalityTypes['F']![q]!.length-1];
          testString2=int.parse(personalityTypes['F']![q]!.substring(0,personalityTypes['F']![q]!.length-1));
          switch (element) {
            case 0:
              if(option1=='a') {
                personalityScores['Thinking'] += testString1;
              }
              else
                {
                  personalityScores['Feeling'] += testString2;
                }
              break;
            case 1:
              if(option1=='b') {
                personalityScores['Thinking'] += testString1;
              }
              else
              {
                personalityScores['Feeling'] += testString2;
              }
              break;
            default:
              print("134:qc.dart");
          }
        } else {
          testString1=int.parse(personalityTypes['J']![q]!.substring(0,personalityTypes['J']![q]!.length-1));
          option1=personalityTypes['J']![q]![personalityTypes['J']![q]!.length-1];
          option2=personalityTypes['P']![q]![personalityTypes['P']![q]!.length-1];
          testString2=int.parse(personalityTypes['P']![q]!.substring(0,personalityTypes['P']![q]!.length-1));
          switch (element) {
            case 0:
              if(option1=='a') {
                personalityScores['Judging'] += testString1;
              } else {
                personalityScores['Perceiving'] += testString2;
              }
              break;
            case 1:
              if(option1=='b') {
                print("j added");
                personalityScores['Judging'] += testString1;
              } else {
                print("p added");
                personalityScores['Perceiving'] += testString2;
              }
              break;
            default:
              if (q == 25) {
                personalityScores['Judging'] += personalityTypes['J']![q]![0];
              } else {
                personalityScores['Perceiving'] += personalityTypes['P']![q]![1];
              }
          }
        }
      }
    }
    if(personalityScores['Extraverted']<=personalityScores['Introverted'])
      {
        finalPersonalityType=finalPersonalityType+'I';
      }
    else
      {
        finalPersonalityType=finalPersonalityType+'E';
      }
    if(personalityScores['Intuitive(N)']>=personalityScores['Sensing'])
    {
      finalPersonalityType=finalPersonalityType+'N';
    }
    else
    {
      finalPersonalityType=finalPersonalityType+'S';
    }
    if(personalityScores['Thinking']>personalityScores['Feeling'])
    {
      finalPersonalityType=finalPersonalityType+'T';
    }
    else
    {
      finalPersonalityType=finalPersonalityType+'F';
    }
    if(personalityScores['Judging']<=personalityScores['Perceiving'])
    {
      finalPersonalityType=finalPersonalityType+'P';
    }
    else
    {
      finalPersonalityType=finalPersonalityType+'J';
    }
    print("__________________________________________");
    print("E:${personalityScores['Extraverted']}");
    print("I:${personalityScores['Introverted']}");
    print("N:${personalityScores['Intuitive(N)']}");
    print("S:${personalityScores['Sensing']}");
    print("T:${personalityScores['Thinking']}");
    print("F:${personalityScores['Feeling']}");
    print("J:${personalityScores['Judging']}");
    print("P:${personalityScores['Perceiving']}");
    print("__________________________________________");
  }
}
