// ignore_for_file: avoid_print

import '../lib/delta_to_html.dart';

void main() {
  List delta = [
    {
      "insert": {"line": 'https://quilljs.com/assets/images/icon.png'}
    }
  ];
  print(DeltaToHTML.encodeJson(delta));
}
