import 'package:delta_to_html/delta_to_html.dart';

void main() async {
  /* Using Flutter_Quill Delta Controller
  
  List delta = deltaController.document.toDelta().toJson();
  print(DeltaToHTML.encodeJson(delta);

  */

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
  // ignore: avoid_print
  print(DeltaToHTML.encodeJson(delta));
}
