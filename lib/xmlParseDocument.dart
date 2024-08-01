import 'package:flutter/services.dart';
import 'package:xml/xml.dart' as xml;

Future<List<String>> xmlParseDocument() async {
  String newDocument = await rootBundle.loadString('MachineData1.xml');
  xml.XmlDocument document = xml.XmlDocument.parse(newDocument);
  String rootElement = document.rootElement.name.toString();
  xml.XmlElement rootNode = document.findElements(rootElement).first;
  Iterable<xml.XmlElement> returnXmlElements = _returnXmlElements(rootNode);
  List<String> returnList = [];
  _returnXmlAttributes(returnXmlElements, returnList);
  return returnList;
}

Iterable<xml.XmlElement> _returnXmlElements(xml.XmlElement testValue) {
  return testValue.childElements;
}

void _returnXmlAttributes(
    Iterable<xml.XmlElement> testValues, List returnList) {
  for (xml.XmlElement testValue in testValues) {
    List<xml.XmlAttribute> testValueAttributes = testValue.attributes;
    for (int j = 0; testValueAttributes.length > j; j++) {
      String testValueName = testValue.name.toString();
      String testValueList = testValueAttributes[j].toString();
      returnList.add("$testValueName $testValueList");
      if (j == testValueAttributes.length - 1 &&
          testValueAttributes.length > 1) {
        String newString = testValue.innerXml;
        returnList.add("Label $newString");
      }
    }
    _returnXmlAttributes(testValue.childElements, returnList);
  }
}
