class Generator {
  String label;
  List<String> arguments;

  Generator(this.label, this.arguments);

  bool hasArgument(String arg) {
    for (var argument in arguments) {
      if (argument == arg) {
        return true;
      }
    }
    return false;
  }
}