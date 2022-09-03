library delta_to_html;

import 'src/encode.dart';

class DeltaToHTML {
  /// Please Pass Delta JSON Value [ using .toJson() ] methods on QuillController  Documents like ( quillController.document.toDelta().toJson() ) to get HTML
  static encodeJson(List value) {
    return encoder(value);
  }
}
