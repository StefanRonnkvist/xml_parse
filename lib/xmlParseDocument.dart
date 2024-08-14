import 'package:flutter/services.dart';
import 'package:xml/xml.dart' as xml;

Future<List<String>> xmlParseDocument() async {
  List<String> returnList = [];
  List<xml.XmlElement> elementLists = [];
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
  returnList.add("Root Element : $rootElement");
  findLastElement(rootNodes, elementLists);
  for (xml.XmlElement node in elementLists) {
    Set<String> parentNodeSet = {};
    parentNodeSet.add(node.toString());
    parentNodeSet.addAll(findElementParent(node, rootElement, parentNodeSet));
    List<String> parentNodeList = parentNodeSet.toList();
    Iterable<String> newParentNodeList=parentNodeList.reversed;
    returnList.add(newParentNodeList.toString());
    parentNodeList.clear();
    parentNodeSet.clear();
  }
  return returnList;
}

void findLastElement(xml.XmlElement nodes, List<xml.XmlElement> elementList) {
  for (xml.XmlElement childNode in nodes.childElements) {
    if (childNode.childElements.isNotEmpty) {
      (findLastElement(childNode, elementList));
    } else {
      elementList.add(childNode);
    }
  }
}

Set<String> findElementParent(
    xml.XmlElement nodes, String rootElement, Set<String> parentNodeList) {
  if (nodes.hasParent) {
    xml.XmlElement parentNode = nodes.parentElement!;
    parentNodeList.add("${parentNode.name} ${parentNode.attributes}");
    if (rootElement != parentNode.name.toString()) {
      findElementParent(nodes.parentElement!, rootElement, parentNodeList);
    }
  }
  return (parentNodeList);
}
