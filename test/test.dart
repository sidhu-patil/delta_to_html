// ignore_for_file: avoid_print

import '../lib/delta_to_html.dart';

void main() {
  List delta = [
    {"insert": "Hello "},
    {
      "insert": "World",
      "attributes": {"bold": true}
    }
  ];
  print(DeltaToHTML.encodeJson(delta));
}
