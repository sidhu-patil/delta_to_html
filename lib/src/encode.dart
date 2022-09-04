import 'dart:convert';

encoder(List delta) {
  var html = '';
  String prevTextValue = '';

  List<Map<String, dynamic>> rawDelta = (delta as List<Map<String, dynamic>>) +
      [
        {'insert': ''}
      ];

  for (var element in rawDelta) {
    if (element['insert'].runtimeType.toString() ==
        '_InternalLinkedHashMap<String, dynamic>') {
      if (element['insert'].containsKey('image')) {
        String imageLink = element['insert']['image'].toString();
        if (element.containsKey('attributes')) {
          String style = element['attributes']['style']
              .toString()
              .replaceAll('mobile', '')
              .replaceAll(':', '="')
              .replaceAll(';', '"')
              .toLowerCase();
          html += "<img src='$imageLink' $style>";
        } else {
          html += "<img src='$imageLink'>";
        }
      } else if (element['insert'].containsKey('video')) {
        String videoLink = element['insert']['image'].toString();
        html += "<embed type='video/webm' src='$videoLink'>";
      }
    } else {
      if (element.containsKey('attributes')) {
        String textValue = element['insert'].toString();
        var attributes = Map.from(element['attributes'] as Map);
        attributes.forEach((key, v) {
          switch (key.toString()) {
            // Inline
            case "color":
              prevTextValue =
                  "$prevTextValue<span style='color:$v'>$textValue</span>";
              break;
            case "background":
              prevTextValue =
                  "$prevTextValue<span style='background-color:$v'>$textValue</span>";
              break;
            case "bold":
              prevTextValue = "$prevTextValue<b>$textValue</b>";
              break;
            case "italic":
              prevTextValue = "$prevTextValue<i>$textValue</i>";
              break;
            case "underline":
              prevTextValue = "$prevTextValue<u>$textValue</u>";
              break;
            case "strike":
              prevTextValue = "$prevTextValue<s>$textValue</s>";
              break;

            case "code":
              prevTextValue =
                  "$prevTextValue<code style='color:#e1103a; background-color:#f1f1f1; padding: 0px 4px;'>$textValue</code>";
              break;

            case "size":
              switch (v) {
                case "small":
                  prevTextValue = "$prevTextValue<small>$textValue</small>";
                  break;
                case "large":
                  prevTextValue = "$prevTextValue<big>$textValue</big>";
                  break;
                case "huge":
                  prevTextValue =
                      "$prevTextValue<span style='font-size:150%'>$textValue</span>";
                  break;
              }
              break;

            case "font":
              prevTextValue =
                  "$prevTextValue<span style='font-family:$v'>$textValue</span>";
              break;

            case "link":
              prevTextValue = "$prevTextValue<a href='$v'>$textValue</a>";
              break;

            //  Block
            case "align":
              prevTextValue =
                  "<span style='text-align:$v'>$prevTextValue</span>";
              break;

            case "header":
              prevTextValue = "<h$v>$prevTextValue</h$v>";
              break;

            case "code-block":
              prevTextValue =
                  "<pre><code style='color:#3F51B5; background-color:#f1f1f1; padding: 0px 4px;'>$prevTextValue</code></pre>";
              break;
            case "blockquote":
              prevTextValue = "<blockqoute>$prevTextValue</blockqoute>";
              break;

            case "indent":
              prevTextValue = "<p>${'&emsp;' * v} $prevTextValue</p>";
              break;

            case "list":
              switch (v) {
                case "ordered":
                  prevTextValue = "<ol><li>$prevTextValue</li></ol>";
                  break;
                case "bullet":
                  prevTextValue = "<ul><li>$prevTextValue</li></ul>";
                  break;
                case "checked":
                  prevTextValue =
                      "<input type='checkbox' checked><lable>$prevTextValue</label><br>";
                  break;
                case "unchecked":
                  prevTextValue =
                      "<input type='checkbox' ><lable>$prevTextValue</label><br>";
                  break;
              }
              break;
          }

          html += prevTextValue;
          if (textValue.contains('\n')) {
            var textList = textValue.split('\n');
            html += textList[0];
            prevTextValue = textList[1];
          } else {
            prevTextValue = '';
          }
        });
      } else {
        html += prevTextValue;
        if (element['insert'].toString().contains('\n')) {
          var textList = element['insert'].toString().split('\n');
          html += textList[0];
          prevTextValue = textList[1];
        } else {
          prevTextValue = element['insert'].toString();
        }
      }
    }
  }

  return jsonEncode(html);
}
