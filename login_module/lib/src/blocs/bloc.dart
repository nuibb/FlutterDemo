import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Object with Validators {
  //final _email = StreamController<String>.broadcast();
  //final _password = StreamController<String>.broadcast();

  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // Change data
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword =>  _password.sink.add;

  // Add data into Stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get submitValid => Rx.combineLatest2(email, password, (e, p) => true);

  submit() {
    print('Email : ' + _email.value + ', Password : ' + _password.value);
  }

  dispose () {
    _email.close();
    _password.close();
  }
}

//final bloc = Bloc();