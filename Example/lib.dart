// ignore_for_file: avoid_print

import 'package:delta_to_html/delta_to_html.dart';
import 'package:flutter_quill/flutter_quill.dart';

void main() {
  // Example 1 [ Using FlutterQuill Delta ]
  final QuillController quillController = QuillController.basic();
  List deltaJson = quillController.document.toDelta().toJson();
  print(DeltaToHTML.encodeJson(deltaJson));

  // Example 2 [ Using Raw Delta ]
  List rawDelta = [
    {"insert": "Hello "},
    {
      "insert": "HTML",
      "attributes": {"bold": true}
    }
  ];
  print(DeltaToHTML.encodeJson(rawDelta));
}
