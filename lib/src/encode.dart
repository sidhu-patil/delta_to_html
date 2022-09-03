encoder(List delta) {
  var html = '';

  for (var element in delta) {
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
          html += '<img src="$imageLink" $style>';
        } else {
          html += '<img src="$imageLink">';
        }
      } else if (element['insert'].containsKey('video')) {
        String videoLink = element['insert']['image'].toString();
        html += '<embed type="video/webm" src="$videoLink">';
      }
    } else {
      if (element.containsKey('attributes')) {
        String textValue = element['insert'].toString();

        var attributes = Map.from(element['attributes'] as Map);
        attributes.forEach((key, v) {
          switch (key.toString()) {

            // Inline
            case "color":
              textValue = '<span style="color:$v">$textValue</span>';
              break;
            case "background":
              textValue = '<span style="background-color:$v">$textValue</span>';
              break;
            case "bold":
              textValue = '<b>$textValue</b>';
              break;
            case "italic":
              textValue = '<i>$textValue</i>';
              break;
            case "underline":
              textValue = '<u>$textValue</u>';
              break;
            case "strike":
              textValue = '<s>$textValue</s>';
              break;

            case "code":
              textValue =
                  '<code style="color:#e1103a; background-color:#f1f1f1; padding: 0px 4px;">$textValue</code>';
              break;

            case "size":
              switch (v) {
                case "small":
                  textValue = '<small>$textValue</small>';
                  break;
                case "large":
                  textValue = '<big>$textValue</big>';
                  break;
                case "huge":
                  textValue = '<span style="font-size:150%">$textValue</span>';
                  break;
              }
              break;

            case "font":
              textValue = '<span style="font-family:$v">$textValue</span>';
              break;

            case "link":
              textValue = '<a href="$v">$textValue</a>';
              break;

            //  Block
            // case "align":
            //   textValue = '<span style="text-align:$v">$textValue</span>';
            //   break;

            // case "header":
            //   textValue = '<h$v>$textValue</h$v>';
            //   break;

            // case "list":
            //   switch (v) {
            //     case "ordered":
            //       textValue = '<ol><li>$textValue</li></ol>';
            //       break;
            //     case "bullet":
            //       textValue = '<ul><li>$textValue</li></ul>';
            //       break;
            //   }
            //   break;
          }
        });

        html += textValue;
      } else {
        html += element['insert'].toString();
      }
    }
  }

  return html;
  // print();
}
