import 'dart:async';

import 'package:rxdart/rxdart.dart';

class SignInBloc implements BaseBloc {
  final _emailbehaviourSubject = BehaviorSubject<String>();
  final _pwdbehaviourSubject = BehaviorSubject<String>();

  Function(String) get emailChanged {
    return _emailbehaviourSubject.sink.add;
  }

  Function(String) get pwdChanged => _pwdbehaviourSubject.sink.add;

  Observable<String> get emailObservable =>
      _emailbehaviourSubject.transform(emailTransformer);

  Observable<String> get passwordObservable =>
      _pwdbehaviourSubject.transform(pwdTramsformer);

  

  //transformers to handle data present in stream
  StreamTransformer<String, String> get emailTransformer =>
      StreamTransformer.fromHandlers(
        handleData: (string, sink) {
          if (string.contains('@'))
            sink.add(string.split('@')[0]);
          else
            sink.addError("Invalid email");
        },
      );
  StreamTransformer<String, String> get pwdTramsformer =>
      StreamTransformer.fromHandlers(
        handleData: (string, sink) {
          if (string.length > 4)
            sink.add(string);
          else
            sink.addError('Password too short');
        },
      );

  Observable<bool> get submitValid => Observable.combineLatest2(
      emailObservable, passwordObservable, (e, p) => true);

  @override
  void dispose() {
    _emailbehaviourSubject?.close();
    _pwdbehaviourSubject?.close();
  }
}

abstract class BaseBloc {
  void dispose();
}
