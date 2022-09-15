# Delta_To_HTML

This library helps you to convert Delta to HTML.

## Usage

```dart
import 'package:delta_to_html/delta_to_html.dart';

void main() {

  List  rawDelta = [{"insert":"Hello "},{"insert":"HTML","attributes":{"bold":true}}];
  print(DeltaToHTML.encodeJson(rawDelta));

  List deltaJson = quillController.document.toDelta().toJson();
  print(DeltaToHTML.encodeJson(deltaJson));
  
}
```

## Supported
Currently, these elements are supported:
  - Bold
  - Italic
  - Underline
  - Background Color
  - Color
  - Font
  - Size
  - Strike
  - Image
  - Video
  - Link
  - Inline Code
  - Blockquote
  - Text Alignment
  - Header
  - List
  - Code Block
  - Indent
  - Text Direction


## Not Supported
Does not support the following elements, because flutter_quill does not support them:
  - Horizontal Rule
  - Superscript/Subscript


Does not support the following elements, because a few problems occur with delta output:
  - Formula

