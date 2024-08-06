import 'package:flutter/services.dart';
import 'package:xml/xml.dart' as xml;

Future<List<String>> xmlParseDocument() async {
  List<String> returnList = [];
  String newDocument = await rootBundle.loadString('president.xml');
  xml.XmlDocument document = xml.XmlDocument.parse(newDocument);
  if (document.declaration?.encoding != null) {
    String string1 = document.declaration!.encoding.toString();
    returnList.add("encoding : $string1");
  }
  if (document.declaration?.version != null) {
    String string1 = document.declaration!.version.toString();
    returnList.add("version : $string1");
  }
  String rootElement = document.rootElement.name.toString();
  xml.XmlElement rootNodes = document.findElements(rootElement).first;
  Iterable<xml.XmlElement> returnXmlElements = _returnXmlElements(rootNodes);
  _returnXmlElementsIterable(returnXmlElements, returnList);
  return returnList;
}

Iterable<xml.XmlElement> _returnXmlElements(xml.XmlElement testValue) {
  return testValue.childElements;
}

void _returnXmlElementsIterable(
    Iterable<xml.XmlElement> testValues, List returnList) {
  String longString = "";
  for (xml.XmlElement testValue in testValues) {
    if (testValue.children.length > 1) {
      _returnXmlElementsIterable(_returnXmlElements(testValue), returnList);
    } else {
      String string1 = testValue.name.toString();
      String string2 = testValue.innerText;
      longString += "$string1 : $string2, ";
      //returnList.add("$string1 : $string2");
    }
    if (testValue.attributes.isNotEmpty) {
      for (xml.XmlAttribute testValueAttributes in testValue.attributes) {
        String string1 = testValueAttributes.name.toString();
        String string2 = testValueAttributes.value.toString();
        longString += "$string1 : $string2, ";
        //returnList.add("$string1 : $string2");
      }
    }
  }
  returnList.add(longString);
}
