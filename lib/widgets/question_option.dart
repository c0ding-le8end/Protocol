import 'package:flutter/material.dart';

class QuestionOption extends StatelessWidget {
  bool isSelected;
  String text;

  int index;

  QuestionOption(this.index, this.text,
      {Key? key, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(30)),
      child: Container(
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
