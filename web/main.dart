import 'dart:convert';
import 'dart:io';

import 'package:CYK_Algorithm/src/cyk_algorithm/cyk_algorithm.dart';
import 'package:CYK_Algorithm/src/cyk_algorithm/cyk_utils.dart';
import 'package:CYK_Algorithm/src/cyk_algorithm/generator.dart';
import 'package:CYK_Algorithm/src/cyk_algorithm/node.dart';

var alternation = true;
var nodeCounter = 0;
var edgeCounter = 0;
var struct = {
  'nodes': [],
  'edges': []
};

void main() {
  var s = Generator('S', [CYK_Utils.epsilon, 'AB', 'XB']);
  var t = Generator('T', ['AB', 'XB']);
  var x = Generator('X', ['AT']);
  var a = Generator('A', ['a']);
  var b = Generator('B', ['b']);
  CYK_Utils.convertToFNC([s, t, x, a, b]);
  var cyk = CYK_Algorithm('aaabbb', [s, t, x, a, b], 'S');
  var json = transformToJSON(cyk.derivationTree.root, 0);
  var file = File('web/data.js');
  var sink = file.openWrite();
  sink.write('data = \'${json}\'\n');
  // Close the IOSink to free system resources.
  sink.close();
}

String transformToJSON(Node root, int x0) {
  var children = root.children;
  var nodeLabel = 'n' + nodeCounter.toString();
  struct['nodes'].add({
    'id': nodeLabel,
    'label': root.label,
    'x': nodeCounter,
    'y': nodeCounter,
    'size': 6,
    'color': '#5cdbb9'
  });
  nodeCounter++;
  root.graphLabel = nodeLabel;
  for (var child in children) {
    processChildren(child, root);
  }
  var data = json.encode(struct);
  return data;
}

void processChildren(Node current, Node parent) {
  var children = current.children;
  struct['edges'].add({
    'id': 'e' + edgeCounter.toString(),
    'target': parent.graphLabel,
    'source': 'n' + nodeCounter.toString()
  });
  edgeCounter++;
  var nodeLabel = 'n' + nodeCounter.toString();
  if (children.isNotEmpty) {
    struct['nodes'].add({
      'id': nodeLabel,
      'label': current.label,
      'x': alternation ? nodeCounter : -nodeCounter,
      'y': nodeCounter,
      'size': 4,
    });
  } else {
    struct['nodes'].add({
      'id': nodeLabel,
      'label': current.label,
      'x': alternation ? nodeCounter : -nodeCounter,
      'y': nodeCounter,
      'size': 2,
      'color': '#e6395f'
    });
  }
  current.graphLabel = nodeLabel;
  nodeCounter++;
  for (var child in children) {
    alternation = !alternation;
    processChildren(child, current);
  }
}
