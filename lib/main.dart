import 'package:flutter/material.dart';
import 'package:login_bloc/bloc/sign_in_bloc.dart';
import 'package:login_bloc/model/user_model.dart';

import 'WelcomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login BLoC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

User user = new User();
SignInBloc _signInBloc = new SignInBloc();

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff7C37F4),
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder<String>(
                  stream: _signInBloc.emailObservable,
                  builder: (ctx, snap) {
                    return Row(children: [
                      Text(
                        'Hello',
                        style: TextStyle(
                            color: Color(
                              0xff000000,
                            ),
                            fontWeight: FontWeight.w900,
                            fontSize: 40.0),
                      ),
                      Text(
                        '.',
                        style: TextStyle(
                            color: Color(
                              0xff7C37F4,
                            ),
                            fontWeight: FontWeight.w900,
                            fontSize: 40.0),
                      ),
                      // snap.hasData ? Text('${snap.data}') : Container()
                    ]);
                  }),
              SizedBox(
                height: 40.0,
              ),
              _buildEmailField(),
              SizedBox(
                height: 15.0,
              ),
              _buildPwdField(),
              SizedBox(
                height: 15.0,
              ),
              _buildSignInBtn()
            ],
          ),
        )),
      ),
    );
  }
}

_buildSignInBtn() {
  return StreamBuilder(
      stream: _signInBloc.submitValid,
      builder: (ctx, snap) =>
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            RaisedButton(
              color: Color(0xff7C37F4),
              onPressed: snap.hasData ? () => submit(ctx) : null,
              child: Text(
                'Sign In',
                style: TextStyle(color: Colors.white),
              ),
            )
          ]));
}

void submit(BuildContext context) {
  print('logged in');
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (ctx) => WelcomePage()));
}

_buildEmailField() {
  return StreamBuilder(
    stream: _signInBloc.emailObservable,
    builder: (ctx, snap) => TextField(
      onChanged: _signInBloc.emailChanged,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
          fillColor: Color(0xff7C37F4).withOpacity(0.4),
          filled: true,
          errorText: snap.error,
          hintText: 'Enter Email',
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.5))),
    ),
  );
}

_buildPwdField() {
  return StreamBuilder(
    stream: _signInBloc.passwordObservable,
    builder: (BuildContext ctx, AsyncSnapshot snap) {
      return TextField(
        onChanged: _signInBloc.pwdChanged,
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            fillColor: Color(0xff7C37F4).withOpacity(0.4),
            filled: true,
            errorText: snap.error,
            hintText: 'Enter Password',
            hintStyle: TextStyle(color: Colors.black.withOpacity(0.5))),
      );
    },
  );
}
