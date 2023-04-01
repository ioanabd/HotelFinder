import 'package:flutter/material.dart';

class AnswerText extends StatefulWidget {
  const AnswerText({Key? key}) : super(key: key);

  @override
  State<AnswerText> createState() => _AnswerTextState();
}

class _AnswerTextState extends State<AnswerText> {
  @override
  Widget build(BuildContext context) {
    bool pressAttention = false;
    return SizedBox(
      width: 340,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: pressAttention ? Colors.grey : Colors.blue,
          foregroundColor: Colors.black,
          elevation: 3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(34.0)),
        ),
        onPressed: () => {
          setState(() => pressAttention = !pressAttention),
        },
        child: const Text('Get started',style: TextStyle(fontSize: 27, decoration: TextDecoration.none),
        ),
      ),
    );
  }
}
