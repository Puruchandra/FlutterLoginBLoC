import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  //SignInBloc bloc;
  //WelcomePage(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        'Hi, Flutter BLoC done right',
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
      ),
      Icon(
        Icons.thumb_up,
        size: 200,
        color: Color(0xff7C37F4),
      )
    ])));
  }
}
