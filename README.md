# Delta_To_HTML

This library helps you to convert Delta to HTML. Based on [Flutter_Quill](https://pub.dev/packages/flutter_quill) Delta 

[ currently in under development ]


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
  - Strikethrough
  - Image
  - Video
  - Link
  - Inline Code

## Under Development
Support for these elements will be added soon::
  - Blockquote
  - Text Alignment
  - Header
  - List
  - Code Block
  - Indent


## Not Supported
Does not support the following elements, because flutter_quill does not support them:
  - Horizontal Rule
  - Superscript/Subscript
  - Text Direction
  - Formula

