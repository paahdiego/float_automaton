import 'dart:io';

void floatValidate(String value) {
  States currentState = States.e0;

  List<States> markedStates = [
    States.e2,
    States.e3,
    States.e5,
    States.e6,
    States.e8,
  ];

  if (value.isNotEmpty) {
    for (int i = 0; i < value.length; i++) {
      print("previousState: $currentState");
      try {
        final result = checkEvent(value[i]);
        switch (currentState) {
          case States.e0:
            switch (result) {
              case Event.number:
                currentState = States.e2;
                break;
              case Event.signal:
                currentState = States.e1;
                break;
              case Event.dot:
                currentState = States.e4;
                break;
              default:
                throw "Not A Valid Float";
            }
            break;
          case States.e1:
            switch (result) {
              case Event.number:
                currentState = States.e2;
                break;
              case Event.dot:
                currentState = States.e4;
                break;
              default:
                throw "Not A Valid Float";
            }
            break;
          case States.e2:
            switch (result) {
              case Event.number:
                break;
              case Event.e:
                currentState = States.e6;
                break;
              case Event.dot:
                currentState = States.e3;
                break;
              default:
                throw "Not A Valid Float";
            }
            break;
          case States.e3:
            switch (result) {
              case Event.number:
                currentState = States.e5;
                break;
              default:
                throw "Not A Valid Float";
            }
            break;
          case States.e4:
            switch (result) {
              case Event.number:
                currentState = States.e5;
                break;
              default:
                throw "Not A Valid Float";
            }
            break;
          case States.e5:
            switch (result) {
              case Event.number:
                break;
              case Event.e:
                currentState = States.e6;
                break;
              default:
                throw "Not A Valid Float";
            }
            break;
          case States.e6:
            switch (result) {
              case Event.number:
                currentState = States.e8;
                break;
              case Event.signal:
                currentState = States.e7;
                break;
              default:
                throw "Not A Valid Float";
            }
            break;
          case States.e7:
            switch (result) {
              case Event.number:
                currentState = States.e8;
                break;
              default:
                throw "Not A Valid Float";
            }
            break;
          case States.e8:
            switch (result) {
              case Event.number:
                break;
              default:
                throw "Not A Valid Float";
            }
            break;
        }
      } catch (error) {
        print("last state before error: $currentState");
        print(error);
        print("\npalavra: $value\n");
        print("\n\nPressione enter para prosseguir ...");
        stdin.readLineSync()!;

        return;
      }
      print("currentState: $currentState");

      print("\n\nPressione enter para prosseguir ...");
      stdin.readLineSync()!;
    }
  } else {
    print("empty");
  }

  print("\npalavra: $value\n");

  if (markedStates.contains(currentState)) {
    print("Número Float válido");
  } else {
    print("Número Float inválido");
  }

  print("\n\nPressione enter para prosseguir ...");
  stdin.readLineSync()!;
}

enum States { e0, e1, e2, e3, e4, e5, e6, e7, e8 }

enum Event { number, signal, dot, e }

Event checkEvent(String event) {
  print("event $event");
  if (event == "+" || event == "-") {
    return Event.signal;
  } else if (event == ".") {
    return Event.dot;
  } else if (event == "e") {
    return Event.e;
  } else {
    final convert = int.tryParse(event);
    if (convert != null) return Event.number;
    throw "Not a valid Number";
  }
}
