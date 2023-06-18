// ignore_for_file: avoid_print

import '../lib/delta_to_html.dart';

void main() {
  List delta = [
    {
      "insert": "Welcome",
      "attributes": {"bold": true, "italic": true, "underline": true}
    },
    {
      "insert": " ",
      "attributes": {"italic": true, "underline": true}
    },
    {
      "insert": "to delta to html package",
      "attributes": {"bold": true, "italic": true, "underline": true}
    },
    {"insert": "\n"}
  ];
  print(DeltaToHTML.encodeJson(delta));
}
