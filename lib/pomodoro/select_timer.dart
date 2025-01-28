import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectTimer extends StatelessWidget {
  final int selectButtonNum;
  final String text;
  bool buttonTrig = false;

  SelectTimer({
    super.key,
    required this.selectButtonNum,
    required this.text,
  });

  void timeSelectPressed() {
    buttonTrig = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white),
      ),
      child: TextButton(
        onPressed: timeSelectPressed,
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
