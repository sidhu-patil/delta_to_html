library delta_to_html;

import 'dart:convert';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:markdown/markdown.dart';
import 'src/delta_markdown_encoder.dart';
import 'src/version.dart';

const version = packageVersion;

const DeltaMarkdownCodec _kCodec = DeltaMarkdownCodec();

String deltaToMarkdown(String delta) {
  return _kCodec.encode(delta);
}

class DeltaMarkdownCodec extends Codec<String, String> {
  const DeltaMarkdownCodec();

  @override
  Converter<String, String> get encoder => DeltaMarkdownEncoder();

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class DeltaToHTML {
  static encode(Delta delta) {
    final convertedValue = jsonEncode(delta.toJson());
    final markdown = deltaToMarkdown(convertedValue);
    final html = markdownToHtml(markdown);
    return html;
  }

  static encodeJson(String delta) {
    final markdown = deltaToMarkdown(delta);
    final html = markdownToHtml(markdown);
    return html;
  }
}
