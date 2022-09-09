import 'dart:convert';
import 'dart:developer';

encoder(List delta) {
  var html = "";
  String prevText = '';

  //! End Loop Implementation
  delta.add({'insert': ' '});

  log(jsonEncode(delta), name: 'Delta');
  for (var element in delta) {
    //! Embeded Implementation
    if (element['insert'].runtimeType.toString() ==
        '_InternalLinkedHashMap<String, dynamic>') {
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
          html += "<img src='$imageLink' $style>";
        } else {
          html += "<img src='$imageLink'>";
        }

        //~ Video Implementation
      } else if (element['insert'].containsKey('video')) {
        String videoLink = element['insert']['image'].toString();
        html += "<embed type='video/webm' src='$videoLink'>";
      }
    } else {
      //! Rich Text Implementation

      //~ Normal Text Implementation
      if (!element.containsKey('attributes')) {
        html += prevText;
        String currentText = element['insert'].toString();
        if (currentText.contains('\n')) {
          List currentTextList = currentText.split('\n');
          html += currentTextList[0];
          currentTextList.remove(currentTextList[0]);
          prevText = '<br>${currentTextList.join("<br>")}';
        } else {
          // html += ;
          prevText = currentText;
        }
      } else {
        List blockElements = [
          'header',
          'align',
          'direction',
          'list',
          'blockqoute',
          'code-block',
          'indent'
        ];
        String currentText = element['insert'].toString();
        Map currentAttributeMap = element['attributes'] as Map;

        //~ Inline Text Implementation
        if (!blockElements.contains(currentAttributeMap.keys.first)) {
          html += prevText;
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
          prevText = currentText;
        } else {
          //~ Block Text Implementation
          currentAttributeMap.forEach((key, value) {
            switch (key.toString()) {
              case "header":
                currentText =
                    "<h$value>${prevText.replaceAll('<br>', '')}</h$value>";
                break;

              case "align":
                currentText =
                    "<p style='text-align:$value'>${prevText.replaceAll('<br>', '')}</p>";
                break;

              case "direction":
                currentText =
                    "<p style='direction:$value'>${prevText.replaceAll('<br>', '')}</p>";
                break;

              case "code-block":
                currentText =
                    "<pre><code style='color:#3F51B5; background-color:#f1f1f1; padding: 0px 4px;'>${prevText.replaceAll('<br>', '')}</code></pre>";
                break;

              case "blockquote":
                currentText =
                    "<blockqoute>${prevText.replaceAll('<br>', '')}</blockqoute>";
                break;

              case "indent":
                currentText =
                    "<p>${'&emsp;' * value} ${prevText.replaceAll('<br>', '')}</p>";
                break;

              case "list":
                switch (value) {
                  case "ordered":
                    currentText =
                        "<ol><li>${prevText.replaceAll('<br>', '')}</li></ol>";
                    break;
                  case "bullet":
                    currentText =
                        "<ul><li>${prevText.replaceAll('<br>', '')}</li></ul>";
                    break;
                  case "checked":
                    currentText =
                        "<input type='checkbox' checked><label>${prevText.replaceAll('<br>', '')}</label><br>";
                    break;
                  case "unchecked":
                    currentText =
                        "<input type='checkbox' ><label>${prevText.replaceAll('<br>', '')}</label><br>";
                    break;
                }
                break;
            }
          });
          html += currentText;
          prevText = '';
        }
      }
    }
  }

  return html;
}
