class Node {
  String _label;
  List<Node> _children;
  String graphLabel;

  Node(String label) {
    _label = label;
    _children = <Node>[];
  }

  void addChild(Node child) {
    _children.add(child);
  }

  @override
  String toString() {
    return _label;
  }

  String get label => _label;

  List<Node> get children => _children;
}