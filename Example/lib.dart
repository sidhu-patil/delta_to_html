import 'package:delta_to_html/delta_to_html.dart';

void main() {
  const delta =
      r'[{"insert":"Hello "},{"insert":"Markdown","attributes":{"bold":true}},{"insert":"\n"}]';
  // print(deltaToHTML(delta));
  print(DeltaToHTML.encodeJson(delta));
}
