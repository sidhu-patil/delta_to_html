encoder(List delta) {
  StringBuffer html = StringBuffer();
  //! End Loop Implementation
  delta.add({'insert': ' '});
  List blockElements = [
    'header',
    'align',
    'direction',
    'list',
    'blockquote',
    'code-block',
    'indent'
  ];

  int listIndex = -1;

  for (var element in delta) {
    listIndex++;

    //! Embedded Implementation
    if (element['insert'] is Map<String, dynamic>) {
      //~ Image Implementation
      if (element['insert'].containsKey('image')) {
        String imageLink = element['insert']['image'].toString();
        if (element.containsKey('attributes')) {
          String style = element['attributes']['style']
              .toString()
              .replaceAll('mobile', '')
              .replaceAll(':', "='")
              .replaceAll(';', "'")
              .toLowerCase();
          html.write("<img src='$imageLink' $style>");
        } else {
          html.write("<img src='$imageLink'>");
        }

        //~ Video Implementation
      } else if (element['insert'].containsKey('video')) {
        String videoLink = element['insert']['video'].toString();
        html.write("<embed type='video/webm' src='$videoLink'>");

        //~ Line Implementation
      } else if (element['insert'].containsKey('line')) {
        html.write("<hr>");
      }
    } else {
      //! Rich Text Implementation

      //~ Normal Text Implementation
      if (!element.containsKey('attributes')) {
        html.write(element['insert'].toString());
      } else {
        String currentText = element['insert'].toString();
        Map currentAttributeMap = element['attributes'] as Map;

        //~ Inline Text Implementation
        if (!blockElements.contains(currentAttributeMap.keys.first)) {
          currentAttributeMap.forEach((key, value) {
            switch (key.toString()) {
              case "color":
                currentText = "<span style='color:$value'>$currentText</span>";
                break;
              case "background":
                currentText =
                    "<span style='background-color:$value'>$currentText</span>";
                break;
              case "font":
                currentText =
                    "<span style='font-family:$value'>$currentText</span>";
                break;

              case "bold":
                currentText = "<b>$currentText</b>";
                break;
              case "italic":
                currentText = "<i>$currentText</i>";
                break;
              case "underline":
                currentText = "<u>$currentText</u>";
                break;
              case "strike":
                currentText = "<s>$currentText</s>";
                break;

              case "size":
                switch (value) {
                  case "small":
                    currentText = "<small>$currentText</small>";
                    break;
                  case "large":
                    currentText = "<big>$currentText</big>";
                    break;
                  case "huge":
                    currentText =
                        "<span style='font-size:150%'>$currentText</span>";
                    break;
                  default:
                    currentText =
                        "<span style='font-size:${value}px'>$currentText</span>";
                    break;
                }
                break;

              case "link":
                currentText = "<a href='$value'>$currentText</a>";
                break;

              case "code":
                currentText =
                    "<code style='color:#e1103a; background-color:#f1f1f1; padding: 0px 4px;'>$currentText</code>";
                break;
              default:
            }
          });
          html.write(currentText);
        } else {
          //~ Block Text Implementation
          String rawHtml = html.toString();
          String blockString = '';
          if (rawHtml.contains('\\Þ')) {
            List dumpyStringList = rawHtml.split('\\Þ');
            blockString = dumpyStringList.last;
            dumpyStringList.removeLast();
            String dumpyString = dumpyStringList.join();
            html.clear();
            html.write(dumpyString);
          } else {
            List dumpyStringList = rawHtml.split('\n');
            blockString = dumpyStringList.last;
            dumpyStringList.removeLast();
            String dumpyString = dumpyStringList.join('\n');
            html.clear();
            html.write(dumpyString);
          }
          currentAttributeMap.forEach((key, value) {
            switch (key.toString()) {
              case "header":
                currentText = "<h$value>$blockString</h$value>";
                break;

              case "align":
                currentText = "<p style='text-align:$value'>$blockString</p>";
                break;

              case "direction":
                currentText = "<p style='direction:$value'>$blockString</p>";
                break;

              case "code-block":
                currentText =
                    "<pre><code style='color:#3F51B5; background-color:#f1f1f1; padding: 0px 4px;'>$blockString</code></pre>";
                break;

              case "blockquote":
                currentText = "<blockquote>$blockString</blockquote>";
                break;

              case "list":
                switch (value) {
                  case "ordered":
                    bool isStart = true, isEnd = true;

                    try {
                      isStart = delta[listIndex - 2]['attributes']['list'] !=
                          "ordered";
                      // ignore: empty_catches
                    } catch (e) {}
                    try {
                      isEnd = delta[listIndex + 2]['attributes']['list'] !=
                          "ordered";
                      // ignore: empty_catches
                    } catch (e) {}

                    if (isStart && isEnd) {
                      currentText = "<ol><li>$blockString</li></ol>";
                    } else {
                      if (isStart) {
                        currentText = "<ol><li>$blockString</li>";
                      } else if (isEnd) {
                        currentText = "<li>$blockString</li></ol>";
                      } else {
                        currentText = "<li>$blockString</li>";
                      }
                    }

                    break;
                  case "bullet":
                    currentText = "<ul><li>$blockString</li></ul>";
                    break;
                  case "checked":
                    currentText =
                        "<input type='checkbox' checked><label>$blockString</label><br>";
                    break;
                  case "unchecked":
                    currentText =
                        "<input type='checkbox' ><label>$blockString</label><br>";
                    break;
                }
                break;

              case "indent":
                currentText = "${'&emsp;' * value} $blockString";
                break;
            }
          });
          html.write('$currentText\\Þ');
        }
      }
    }
  }

  return html.toString().replaceAll('\\Þ', '').replaceAll('\n', '<br>');
}
