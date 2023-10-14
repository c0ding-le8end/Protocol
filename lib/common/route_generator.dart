import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protocol/controllers/AuthController.dart';
import 'package:protocol/screens/about_page.dart';
import 'package:protocol/screens/leadership_styles.dart';
import 'package:protocol/screens/test_screen.dart';
import 'package:protocol/screens/user_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/category.dart';
import '../models/dto/quiz_result.dart';
import '../models/quiz.dart';
import '../screens/home_screen.dart';
import '../screens/quiz_category.dart';
import '../screens/quiz_category_details.dart';
import '../screens/quiz_history_screen.dart';
import '../screens/quiz_result_screen.dart';
import '../screens/quiz_screen.dart';
import '../screens/resultScreen.dart';
import '../screens/splash_screen.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      // case SplashScreen.routeName:
      //   return MaterialPageRoute(builder: (_) => SplashScreen());
      case UserForm.routeName:
        return MaterialPageRoute(builder: (_)=>UserForm());
        break;
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case StylesScreen.routeName:
        if(args is String)
          {

        return MaterialPageRoute(builder: (_) =>StylesScreen(args));
          }return _errorRoute();
      case AboutPage.rootName:
        return MaterialPageRoute(builder: (_)=>AboutPage());

      case QuizScreen.routeName:
        if (args is Quiz) {
          return MaterialPageRoute(
            builder: (_) => QuizScreen(),
          );
        }
        return _errorRoute();
      case ResultScreen.routeName:
          return MaterialPageRoute(
            builder: (_) => ResultScreen(),
          );
      case TestScreen.routeName:
        return MaterialPageRoute(builder: (_)=>TestScreen());
      case QuizCategoryScreen.routeName:
        return MaterialPageRoute(builder: (_) => QuizCategoryScreen());
      case QuizHistoryScreen.routeName:
        return MaterialPageRoute(builder: (_) => QuizHistoryScreen());
      case QuizCategoryDetailsScreen.routeName:
        if (args is Category) {
          return MaterialPageRoute(
            builder: (_) => QuizCategoryDetailsScreen(args),
          );
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text(
            'ERROR: Please try again.',
            style: TextStyle(fontSize: 32),
          ),
        ),
      );
    });
  }
}
