import 'dart:io';

import 'package:sed_float/sed_float.dart';

void main(List<String> arguments) {
  print('\nDigite a palavra\n');
  final value = stdin.readLineSync()!;

  floatValidate(value);
}
